require 'spec_helper'

describe RegistrationsController do
	before do
		@request.env["devise.mapping"] = Devise.mappings[:user]
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
		subject { post :create, params }

		describe 'change user and weather count' do
			specify {expect{subject}.to change(User, :count).by(1)}
			specify {expect{subject}.to change(Weather, :count).by(1)}
			specify {expect(response).to be_success}
		end

		describe 'when submitting an already used zip_code' do
			let!(:weather) { create(:weather)}
			describe 'updates existing weather instead of making new' do
				before do
					weather.update_column(:updated_at, 1.hour.ago)
				end

				specify do
					expect(Weather).to receive(:find_by_zip_code).and_return(weather)
					expect{ subject; weather.reload }.to change(weather, :updated_at)
					expect{subject}.not_to change(Weather, :count).by(1)
					expect{ subject; weather.reload }.to_not change(weather, :updated_at)
				end

			end
		end

	end

end
