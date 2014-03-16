class RegistrationsController < Devise::RegistrationsController
	def new
		@zip_code = Weather.new
		super
	end

	def create
		zip_code = weather_params

		@weather = Weather.get_weather zip_code
		session[:zip_code] = zip_code['zip_code']
		super
	end

	def cancel
		super
	end

	def edit
		super
	end

	def update
		super
	end

	def destroy
		super
	end

	protected

		def after_sign_up_path_for(resource)
			@weather
		end

	private

		def weather_params
			params.require(:weather).permit(:zip_code)
		end
end
