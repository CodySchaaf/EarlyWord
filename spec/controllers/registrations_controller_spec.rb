require 'spec_helper'

describe RegistrationsController do
	before do
		@request.env["devise.mapping"] = Devise.mappings[:user]
	end

	describe 'submiting to the new action' do
		before {get :new}

		subject {response}

		it { should render_template :new}
		it 'assignes zip_code' do
			assigns(:zip_code).should be_a(Weather)
		end
	end

	describe 'submiting to the create action' do
		let(:params) { {user: attributes_for(:user), weather: attributes_for(:zip_code)} }

		subject do
	    post :create, params
		end


		it 'changes user count' do
			expect{subject}.to change(User, :count).by(1)
		end

		it 'changes weather count' do
			expect{subject}.to change(Weather, :count).by(1)
		end

		it 'responds with success' do
			expect(response).to be_success
		end

		describe 'when submitting an already used zip_code' do
			let!(:weather) do
					create(:weather)
			end

			# it 'doesn\'t change weather count' do
			# end

			describe 'updates existing weather instead of making new' do
				before do
					weather.update_column(:updated_at, 1.hour.ago)
				end

				it do
					Weather.should_receive(:find_by_zip_code).and_return(weather)
					expect{ subject; weather.reload }.to change(weather, :updated_at)
					expect{subject}.not_to change(Weather, :count).by(1)
					expect{ subject; weather.reload }.to_not change(weather, :updated_at)
				end

			end
		end

	end

end
