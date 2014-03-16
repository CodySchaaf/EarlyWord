class WeathersController < ApplicationController
	before_action :has_zip_code?, only: [:new, :create]
	def new
		@weather = Weather.new
	end

	def create
		zip_code = weather_params

		@weather = Weather.get_weather zip_code

		session[:zip_code] = zip_code['zip_code']
		redirect_to @weather
	end

	def show
		@weather = Weather.find(params[:id])

		user_weather = @weather.json

		@current_observation = user_weather['current_observation']
	end

	protected

		def has_zip_code?
			redirect_to (Weather.find_by_zip_code(session[:weather][:zip_code])) if session[:weather]
		end

	private

		def weather_params
			params.require(:weather).permit(:zip_code)
		end
end
