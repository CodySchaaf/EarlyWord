class RegistrationsController < Devise::RegistrationsController
	before_filter :update_sanitized_params,  :only => [:create]

	def new
		@zip_code = Weather.new
		super
	end

	def create
		zip_code = weather_params
		@weather = Weather.get_weather zip_code
		session[:zip_code] = zip_code['zip_code']

		params[:user][:zip_code_id] = @weather.id

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

		def update_sanitized_params
			devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :zip_code_id) }
		end

	private

		def weather_params
			params.require(:weather).permit(:zip_code)
		end

end
