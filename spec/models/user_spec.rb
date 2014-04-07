require 'spec_helper'

describe User do
	let(:user) { build :user }

	subject { user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:weather_id) }
	it { should respond_to(:password) }

	it { should be_valid }

	describe 'when email is not present' do
		before { user.email = ' ' }
		it { should_not be_valid }
	end

	describe 'when email address is already taken' do
		before do
			user_with_same_email       = user.dup
			user_with_same_email.email = user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe 'when password is not present' do
		subject(:user) { User.new(name:     'Example User', email: 'user@example.com',
		                          password: ' ', password_confirmation: ' ') }
		it { should_not be_valid }

		describe 'when password doesn\'t match confirmation' do
			before { user.password_confirmation = 'mismatch' }
			it { should_not be_valid }
		end
	end

	describe 'when calling zip_code on a user' do
		let(:user) { create(:user) }
		it 'returns the user\'s zip_code' do
			expect(user.zip_code).to be(Weather.last.zip_code)
		end

	end

	describe 'when creating a new user' do
		subject(:user) { create :user }
		before do
			allow_any_instance_of(User).to receive(:set_forecast_schedule).and_call_original
			allow_any_instance_of(User).to receive(:schedule_forecast_email).and_call_original
			allow_any_instance_of(User).to receive(:send_sign_up_email).and_call_original
			subject
		end

		describe 'set_forecast_schedule' do
			it 'called on user' do
				expect(user).to have_received(:set_forecast_schedule)
			end

			it 'sets the forecast_scheduled_at' do
				expect(user.forecast_scheduled_at).to eq(Time.zone.parse('06:00:00 AM'))
			end
		end

		describe 'schedule_forecast_email' do
			let(:handler) { YAML::load(Delayed::Job.last.handler) }
			it 'called on user' do
				expect(user).to have_received(:schedule_forecast_email)
			end

			it 'schedules the forecast email for this user' do
				expect(handler.user).to eq(user)
			end
		end

		describe 'send_sign_up_email' do
			it 'called on user' do
				expect(user).to have_received(:send_sign_up_email)
			end

			it 'sends sign_up email' do
				Delayed::Worker.new.work_off
				expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
			end
		end

		describe 'update_forecast_schedule' do
			it 'sets the users forecast_scheduled_at' do
				expect {user.update_forecast_schedule}.to change(
						user, :forecast_scheduled_at
				     ).from(Time.zone.parse('06:00:00 AM')).to(Time.zone.parse('06:00:00 AM').tomorrow)
			end
		end
	end
end
