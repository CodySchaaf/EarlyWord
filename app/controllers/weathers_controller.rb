class WeathersController < ApplicationController
	def new
		@weather = Weather.new
	end

	def create
		zip_code = weather_params

		@weather = Weather.get_weather zip_code

		session[:weather] = zip_code
		redirect_to @weather
	end

	def show
		#zip_code = session[:weather]
		#
		#@weather = Weather.find_by_zip_code zip_code
		#
		#
		#@current_observation = user_weather['current_observation']
		@weather = Weather.find(params[:id])

		user_weather = @weather.json

		@current_observation = user_weather['current_observation']
	end

	private

		def weather_params
			params.require(:weather).permit(:zip_code)
		end
end
