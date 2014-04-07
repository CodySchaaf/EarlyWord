class RegistrationsController < Devise::RegistrationsController
	before_filter :update_sanitized_params,  :only => [:create, :new]
	before_filter :authenticate_user! #rescue redirect_to root

	def new
		@zip_code = Weather.new
		super
	end

	def create
		zip_code = Weather.new(weather_params)
		@weather = Weather.get_weather zip_code
		@zip_code = Weather.new

		#unless @weather.json_valid?
		#	set_flash_message(:devisefailure, :invalid_zip_code)
		#	flash[:alert] = 'We can\'t seem to find this zip_code in our records.'
		#	redirect_to new_user_registration_path and return
		#end

		session[:zip_code] = @weather.zip_code

		params[:user][:weather_id] = @weather.id
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
			devise_parameter_sanitizer.for(:sign_up).push(:weather_id, :name)
		end

	private

		def weather_params
			params.require(:weather).permit(:zip_code)
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
