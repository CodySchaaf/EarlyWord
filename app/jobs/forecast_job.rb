class ForecastJob < Struct.new(:user)
	def perform
		Forecast.send_forecast_email(user)
		user.update_forecast_schedule
		user.schedule_forecast_email
	end

	#Todo think about this
	def max_attempts
		3
	end
end