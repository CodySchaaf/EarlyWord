require 'spec_helper'

describe WeathersController do
	describe 'submitting to the new action' do
		before { get :new }

		subject {response}

		it { should be_success }
		it { should render_template :new }
		it 'assigns zip_code' do
			expect(assigns(:weather)).to be_a_new(Weather)
		end
	end

	describe 'submitting to the create action' do
		let(:params) { {weather: attributes_for(:zip_code)} }

		subject do
			post :create, params
		end

		describe 'changes weather count' do
			puts "These are all the weathers 1: #{Weather.all.map(&:id)}"
			specify {expect{subject}.to change(Weather, :count).by(1)}
			puts "These are all the weathers 2: #{Weather.all.map(&:id)}"
			specify {expect(response).to be_success}
			puts "These are all the weathers 3: #{Weather.all.map(&:id)}"
		end

		describe 'when submitting an already used zip_code' do
			let!(:weather) {create(:weather)}
			before do
				weather.update_column(:updated_at, 1.hour.ago)
			end

				it 'updates existing weather instead of making new one' do
					expect(Weather).to receive(:find_by_zip_code).and_return(weather)
					expect{ subject; weather.reload }.to change(weather, :updated_at)
					expect{subject}.not_to change(Weather, :count).by(1)
					expect{ subject; weather.reload }.to_not change(weather, :updated_at)
				end
		end
	end

end
