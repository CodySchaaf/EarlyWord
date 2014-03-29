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
			let!(:params) { {user: attributes_for(:user), weather: weather.attributes } }
			describe 'updates existing weather instead of making new' do
				before do
					weather.update_column(:updated_at, 1.hour.ago)
				end

				it 'updates weather' do
					expect(Weather).to receive(:find_by_zip_code) {weather}
					expect{ subject; weather.reload }.to change(weather, :updated_at)
				end
				it 'increases user count' do
					expect{subject}.to change(User, :count).by(1)
				end
				it 'does not increase weather count' do
					expect{subject}.to_not change(Weather, :count)
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

	describe 'when forbidden attributes are posted' do
		let(:zip_code) { attributes_for :zip_code }
		let(:user)     { attributes_for :user }
		subject{ post :create, weather: zip_code, user: user }

		it 'will not be written to the database from user input' do
			zip_code[:json] = 'Nafariouse code!'
			subject
			expect(Weather.last.json).to_not eq('Nafariouse code!')
			end

		it 'will not be written to the database from user input' do
			user[:weather_id] = '0'
			subject
			expect(User.last.weather_id).to_not eq('0')
		end

		it 'weather_params will only allow zip code through' do
			zip_code[:json] = 'Nafariouse code!'
			subject
			expect(controller.send(:weather_params)).to(
					eq(zip_code.reject {|key,value| key == :json}.stringify_keys)
			)
		end

		it 'weather_params will only allow zip code through' do
			user[:weather_id] = '0'
			subject
			expect(controller.send(:user_params)).to(
					eq(user.reject {|key,value| key == :weather_id}.stringify_keys)
			)
		end

		describe 'devise_parameter_sanitizer will allow weather_id to be set by controller' do
			it 'weather_id will be written to the database from controller input' do
				subject
				expect(User.last.weather_id).to be(Weather.last.id)
			end

			it 'allows the user to have weather_id attribute' do
				subject
				expect(controller.send(:devise_parameter_sanitizer).resource_class.column_names).to(
						include('weather_id')
				)
			end

			it 'allows the user to have forecast_scheduled_at attribute' do
				subject
				expect(controller.send(:devise_parameter_sanitizer).resource_class.column_names).to(
						include('forecast_scheduled_at')
				)
			end

			it 'allows the controller to set the user\'s weather_id' do
				subject
				expect(controller.send(:devise_parameter_sanitizer).params['user']).to(
						include(weather_id: Weather.last.id)
				)
			end

		end
	end
end
