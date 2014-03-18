class Forecast < ActionMailer::Base
  default css: 'emails/email', from: 'word.early@gmail.com'

  def send_sign_up_email(user)
	  @user = user
	  @user = user
	  mail( :to => @user.email,
	        :subject => 'Thanks for signing up for our amazing app')
	  end


  def send_forecast_email(user)
	  @user = user
	  mail(
			  to: @user.email,
        subject: 'Good Morning, here is your daily forecast!',
        css: 'emails/forecast'
	  )
  end
end
