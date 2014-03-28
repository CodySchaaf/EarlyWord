require 'spec_helper'

describe RegistrationsController do
	before do
		@request.env['devise.mapping'] = Devise.mappings[:user]
	end

	describe 'submiting to the new action' do
		before {get :new}

		subject {response}

		it { should be_success }
		it { should render_template :new}

		it 'assigns zip_code' do
			expect(assigns(:zip_code)).to be_a_new(Weather)
		end

		it 'assigns user' do
			expect(assigns(:user)).to be_a_new(User)
		end
	end

	describe 'submitting to the create action' do
		let(:params) { {user: attributes_for(:user), weather: attributes_for(:zip_code)} }
		subject {post :create, params }

		specify {expect(response).to be_success}
		specify 'new user changes user count' do
			expect{subject}.to change(User, :count).by(1)
			expect(Weather.all.first).to be_json_valid
		end
		specify 'new zip code changes weather count' do
			expect{subject}.to change(Weather, :count).by(1)
		end

		describe 'when submitting an already used zip_code' do
			let!(:weather) { create(:weather)}
			describe 'updates existing weather instead of making new' do
				before do
					weather.update_column(:updated_at, 1.hour.ago)
				end

				it 'updates weather' do
					expect(Weather).to receive(:find_by_zip_code).and_return(weather)
					expect{ subject; weather.reload }.to change(weather, :updated_at)
				end
				it 'increases user count' do
					expect{subject}.to change(User, :count).by(1)
				end
				it 'does not increase weather count' do
					expect{subject}.to_not change(Weather, :count).by(1)
				end
			end
		end

		describe 'when submitting an invalid zip code' do
			let(:params) { {user: attributes_for(:user), weather: attributes_for(:zip_code, zip_code: 90000)} }
			subject {post :create, params }
			before do
				allow(Weather).to receive(:get_current_weather).and_return(get_fake_weather)
			end
			it 'creates new user' do
				expect{subject}.to change(User, :count).by(1)
			end
			it 'creates new weather' do
				expect{subject}.to change(Weather, :count).by(1)
			end
			it 'redirects to root' do
				subject
				expect(Weather.all.first).not_to be_json_valid
				expect(subject).to redirect_to(Weather.all.first)
			end

		end
	end

end
