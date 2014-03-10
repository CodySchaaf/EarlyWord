class UsersController < ApplicationController
	def weather
		Barometer.config = { 1 => [:yahoo], 2 => :wunderground }
		barometer = Barometer.new('94116')
		weather = barometer.measure

		@user_weather = weather.responses.first.current

		#weather.responses.first.forecast
	end
end
