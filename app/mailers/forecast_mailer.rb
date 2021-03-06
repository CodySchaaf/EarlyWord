class ForecastMailer < ActionMailer::Base
	add_template_helper ForecastMailersHelper
	default css: 'emails/email', from: 'word.early@gmail.com'

  def sign_up_email(user)
	  @user = user
	  @user = user
	  mail( :to => @user.email,
	        :subject => 'Thanks for signing up for our amazing app')
  end


  def forecast_email(user)
		logger.debug('We are inside the send forecast_mailer email method!')
		puts('We are inside the send forecast_mailer email method!')
	  @user = user
		@weather = user.weather.update_json!
		attachments.inline['sunny_weather.jpe'] = File.read('app/assets/images/sunny_weather.jpe')
	  mail(
			  to: @user.email,
        subject: 'Good Morning, here is your daily forecast!',
        css: 'emails/forecast'
	  )
  end
end