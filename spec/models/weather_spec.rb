require 'spec_helper'

describe Weather do
	let(:weather) { build :weather }
	before {allow(Weather).to receive(:get_current_weather).with(kind_of(Numeric)) {get_fake_found_weather}}

	subject{ weather }

	it { should respond_to(:zip_code) }
	it { should respond_to(:json) }
	it { should respond_to(:updated_at) }

	it { should be_valid }

	describe 'non-valid zip_code' do

		describe 'with no zip_code' do
			before { weather.zip_code = ' ' }
			it { should_not be_valid }
		end

		describe 'with invalid length' do
			it 'too long' do
				weather.zip_code = '111111'
				should_not be_valid
			end

			it 'too short' do
				weather.zip_code = '1111'
				should_not be_valid
			end
		end

		describe 'with invalid format' do
			before { weather.zip_code = '11s11' }
			it { should_not be_valid }
		end
	end

	describe 'calling current? and updating json' do
		it 'when updated_at is less than an hour old' do
			weather.updated_at = Time.current
			expect(weather).to be_current
		end

		describe 'a newly updated weather' do
			let!(:weather) { create :weather }
			before {
				weather.update_attribute(:updated_at, 1.day.ago)
				#weather.save!
			}
			subject {weather}
			it 'before update' do
				should_not be_current
			end

			describe 'after update' do
				before do
					Timecop.freeze
					weather.update_json
					weather.reload
				end
				after {Timecop.return}

				it { should be_current }
				its(:updated_at) { should eq Time.now }
			end
		end
	end

	describe 'calling get_weather' do
		let!(:old_weather) { create(:weather) }

		describe 'updating existing weather in the db' do
			let(:new_weather) { build(:weather, zip_code: old_weather.zip_code) }
			subject { Weather.get_weather(new_weather); old_weather.reload }

			describe 'less than an hour later' do
				specify { expect{subject}.not_to change(Weather,:count) }
				specify { Timecop.freeze { expect{subject}.not_to change(old_weather, :updated_at)}}
			end

			specify 'more than an hour ago' do
				Timecop.travel(2.hours.from_now) do
					expect{subject}.to change(old_weather, :updated_at)
				end
			end
		end

		describe 'adding new weather to the db' do
			let(:new_weather) { build(:weather) }
			subject { Weather.get_weather(new_weather); old_weather.reload }

			specify { expect{subject}.to change(Weather,:count) }
			specify { Timecop.freeze { expect{subject}.not_to change(old_weather, :updated_at)}}
		end
	end

	describe 'json_valid?' do
		let(:not_found_weather) { create :weather, :not_found }
		let(:weather) { create :weather}

		specify 'that a not found weather does not have valid json' do
			expect(not_found_weather).to_not be_json_valid
			expect(not_found_weather).to be_not_found
		end

		specify 'that found weather has valid json' do
			expect(weather).to be_json_valid
			expect(weather).to_not be_not_found
		end
	end

	describe 'creat_new weather instance' do
		let(:new_weather) { Weather.new }
		before do
			new_weather.zip_code = ((build :weather).zip_code)
		end
		subject { Weather.create_new(new_weather) }

		it { expect{subject}.to change(Weather, :count).by(1) }
		it {
			subject
			expect(Weather.last.zip_code).to eq(new_weather.zip_code)
			expect(Weather.last.json).to have_key('response')
		}
	end
end
