class UsersController < ApplicationController
	def weather
		#Barometer.config = { 1 => [:yahoo], 2 => :wunderground }
		#barometer = Barometer.new('94116')
		#weather = barometer.measure
		#TODO if zip code is stored in db already dont request new one!

		response = Typhoeus.get("http://api.wunderground.com/api/xxxxxxxxxxxxxx/forecast/conditions/hourly/q/94116.json", followlocation: true)
		parsed_json = JSON.parse(response.body)

		@user_weather = parsed_json
		@current_observation = @user_weather['current_observation']

		#weather.responses.first.forecast
	end
end
