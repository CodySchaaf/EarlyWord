class ForecastMailer < ActionMailer::Base
  default css: 'emails/email', from: 'word.early@gmail.com'

  def send_sign_up_email(user)
	  @user = user
	  @user = user
	  mail( :to => @user.email,
	        :subject => 'Thanks for signing up for our amazing app')
  end


  def send_forecast_email(user)
		logger.debug('We are inside the send forecast_mailer email method!')
	  @user = user
		@weather = Weather.find(user.weather_id)
	  mail(
			  to: @user.email,
        subject: 'Good Morning, here is your daily forecast!',
        css: 'emails/forecast'
	  )
  end
end



# if Rails.env.development?
# 	class ForecastMailer::Preview < MailView
# 		# default css: 'emails/email', from: 'word.early@gmail.com'
#
# 		# def send_sign_up_email(user)
# 		# 	@user = user
# 		# 	@user = user
# 		# 	mail( :to => @user.email,
# 		# 	      :subject => 'Thanks for signing up for our amazing app')
# 		# end
#
#
# 		def send_forecast_email
# 			user = User.first || User.new(name: 'Cody', email: 'cody@csc8.com', weather_id: (Weather.find_by_zip_code('94116') || Weather.create_new(Weather.new(zip_code: '94116'))).id)
# 			ForecastMailer.send_forecast_email(user)
# 		end
# 	end
# end