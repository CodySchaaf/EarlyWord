class ForecastJob < Struct.new(:user)
	def perform
		ForecastMailer.forecast_email(user).deliver!
		user.update_forecast_schedule
		user.schedule_forecast_email
	end

	#Todo think about this
	def max_attempts
		3
	end
end