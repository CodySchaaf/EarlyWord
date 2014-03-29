require 'spec_helper'

describe User do
	before { @user = build :user }
			#User.new(name: "Example User", email: "user@example.com", password: 'foobaring', password_confirmation: 'foobaring')}

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:weather_id) }
	it { should respond_to(:password) }

	it { should be_valid }

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe 'when password is not present' do
		before do
			@user = User.new(name: "Example User", email: 'user@example.com',
			                 password: " ", password_confirmation: " ")
		end
		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

end
