class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :weather
	after_create :send_sign_up_email

	private

		def send_sign_up_email
			logger.debug('We are now doing send_sign_up_email.')
			Forecast.send_sign_up_email(self).deliver!
		end

end
