class WeatherController < ApplicationController
	def new
		@weather = Weather.new
	end

	def create
		zip_code = weather_params[:weather]

		@weather = Weather.get_weather zip_code

		user_weather = @weather.json

		@current_observation = user_weather['current_observation']

		redirect_to :show
	end

	def show

	end
end
