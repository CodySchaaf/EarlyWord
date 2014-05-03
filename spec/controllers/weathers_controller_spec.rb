require 'spec_helper'

describe WeathersController do
	include Devise::TestHelpers

	describe 'submitting to the new action' do
		before { get :new }

		subject {response}

		it { should be_success }
		it { should render_template :new }
		it 'assigns zip_code' do
			expect(assigns(:weather)).to be_a_new(Weather)
		end

		specify 'preferred_zip_code returns nil' do
			expect(controller.send(:preferred_zip_code)).to be_nil
		end

	end

	describe 'submitting to the create action' do
		let(:params) { {weather: attributes_for(:zip_code)} }

		subject do
			post :create, params
		end

		describe 'changes weather count' do
			specify {expect{subject}.to change(Weather, :count).by(1)}
			specify {expect(response).to be_success}
		end

		describe 'with no current user but with session[:zip_code]' do
			specify 'preferred_zip_code returns session zip_code' do
				subject
				expect(session[:zip_code]).to eq(Weather.last.zip_code)
				expect(controller.send(:preferred_zip_code)).to eq(session[:zip_code])
			end
		end

		describe 'with current user' do
			let(:user) { FactoryGirl.create :user, weather: Weather.last }
			before do
				subject
				allow(controller).to receive(:current_user) {user}
			end

			describe 'without session zip code' do
				specify 'preferred_zip_code returns users zip code' do
					expect(controller.send(:preferred_zip_code)).to eq(user.zip_code)
				end
			end

			describe 'preferred_zip_code returns users zip code' do
				before {session[:zip_code] = 10000}

				it 'returns user\'s zip code' do
					expect(controller.send(:preferred_zip_code)).to eq(user.zip_code)
				end

				it 'doesn\'t return session\'s zip code' do
					expect(controller.send(:preferred_zip_code)).not_to eq(session[:zip_code])
				end
			end
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

		describe 'when submitting to the show action' do
			before do
				subject
				allow(Weather.last).to receive(:json_valid?) {true}
				get :show, id: Weather.last
			end

			it 'responds successfully with an HTTP 200 status code' do
				expect(response).to be_success
				expect(response.status).to eq(200)
			end

			it 'renders the show page succesfully' do
				expect(response).to render_template(:show)
			end

			it 'loads the weather into @weather' do
				expect(assigns(:weather)).to eq(Weather.last)
			end

			it 'loads the current_weather into response' do
				expect(assigns(:response)).to be_a(WeatherResponse)
			end
		end
	end

	describe 'submitting to the show action with invalid zip_code' do
		let(:params) { { weather: attributes_for(:zip_code, zip_code: 90000)} }
		subject {post :create, params }
		before do
			allow(Doppler).to receive(:get_current_weather).and_return(get_fake_not_found_weather)
		end

		it 'returns success' do
			subject
			expect(response).to be_redirect
			expect(response).to redirect_to(Weather.first)
		end
		it 'creates a new weather entry' do
			expect{subject}.to change(Weather,:count).by(1)
		end
		describe 'redirects to the home page' do
			before do
				subject
				allow(Weather.last).to receive(:json_valid?) {false}
				allow(controller).to receive(:check_zip_code).and_call_original
				get :show, id: Weather.last
			end

			it 'calls check_zip_code' do
				expect(controller).to have_received(:check_zip_code)
			end

			it 'loads the weather into @weather' do
				expect(assigns(:weather)).to eq(Weather.last)
			end

			it 'loads the current_weather into @current_observation' do
				expect(assigns(:current_observation)).to be(nil)
			end

			it 'responds with redirect and an HTTP 302 status code' do
				expect(response).to be_redirect
				expect(response.status).to eq(302)
			end

			it 'redirects to the home page' do
				expect(response).to redirect_to(root_url)
			end

			it 'has error message' do
				expect(flash[:alert]).to include('We can\'t seem to find this zip_code in our records.')
			end
		end
	end

	describe 'when forbidden attributes are posted' do
		let(:zip_code) { attributes_for :zip_code }
		subject{ post :create, weather: zip_code }

		it 'will not be written to the database from user input' do
			zip_code[:json] = 'Nafariouse code!'
			subject
			expect(Weather.last.json).to_not eq('Nafariouse code!')
		end

		it 'weather_params will only allow zip code through' do
			zip_code[:json] = 'Nafariouse code!'
			subject
			expect(controller.send(:weather_params)).to(
					eq(zip_code.reject {|key,value| key == :json}.stringify_keys)
			)
		end
	end
end
