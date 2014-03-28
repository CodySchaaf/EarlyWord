class WeathersController < ApplicationController
	before_action :has_zip_code?, only: [:new, :create]
	before_action :check_zip_code, only: [:show]
	def new
		@weather = Weather.new
	end

	def create
		zip_code = Weather.new(weather_params)

		@weather = Weather.get_weather zip_code

		session[:zip_code] = @weather.zip_code

		if signed_in?
			current_user.update_attributes!(zip_code_id: @weather.id)
		end

		redirect_to @weather
		#if @weather.json_valid?
		#else
		#	flash[:alert] = 'We can\'t seem to find this zip_code in our records.'
		#	redirect_to :back
		#end
	end

	def show
		@weather = Weather.find(params[:id])
		user_weather = @weather.json

		@current_observation = user_weather['current_observation']
	end

	protected

		def check_zip_code
			puts 'Checking zip Code'
			unless Weather.find(params[:id]).json_valid?
				flash[:alert] = 'We can\'t seem to find this zip_code in our records.'
				redirect_to root_path
			end
		end

		def has_zip_code?
			if preferred_zip_code
				redirect_to Weather.find_by_zip_code(preferred_zip_code)
			end
		end

		def preferred_zip_code
			(current_user && current_user.zip_code) || session[:zip_code]
		end

	private

		def weather_params
			params.require(:weather).permit(:zip_code)
		end
end
