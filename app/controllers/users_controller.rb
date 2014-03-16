class UsersController < Devise::RegistrationsController
	def new
		@zip_code = Weather.new
		super
	end

	def create
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
end
