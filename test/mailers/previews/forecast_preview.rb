class ForecastPreview < ActionMailer::Preview
	# view at http://localhost:3000/rails/mailers
	def send_sign_up_email
		# Mock up some data for the preview
		user = User.first || FactoryGirl.build(:user)

		# Return a Mail::Message here (but don't deliver it!)
		ForecastMailer.sign_up_email(user)
	end

	def send_forecast_email
		user = User.first || FactoryGirl.build(:user)
		ForecastMailer.forecast_email(user)
	end
end