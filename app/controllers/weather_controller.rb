class WeatherController < ApplicationController
	def new
		#Barometer.config = { 1 => [:yahoo], 2 => :wunderground }
		#barometer = Barometer.new('94116')
		#weather = barometer.measure

		zip_code = '94118'

		@user_weather = Weather.get_weather zip_code

		@current_observation = @user_weather['current_observation']

		#weather.responses.first.forecast
	end
end
