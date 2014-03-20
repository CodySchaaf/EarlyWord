class RegistrationsController < Devise::RegistrationsController
	before_filter :update_sanitized_params,  :only => [:create, new]
	before_filter :authenticate_user! #rescue redirect_to root

	def new
		@zip_code = Weather.new
		super
	end

	def create
		@zip_code = Weather.new(weather_params)
		@weather = Weather.get_weather @zip_code
		session[:zip_code] = @zip_code.zip_code

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
			devise_parameter_sanitizer.for(:sign_up) << :zip_code_id
		end

	private

		def weather_params
			params.require(:weather).permit(:zip_code)
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
