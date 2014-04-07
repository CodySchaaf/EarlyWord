EarlyWord::Application.routes.draw do
	#devise_for :users, except: [:registrations]
	devise_for :users, :controllers => { :registrations => 'registrations' }

	root 'weathers#new'

	resources :weathers, only: [:new, :create, :show]

	# if Rails.env.development?
	# 	mount ForecastMailer::Preview => 'mail_view'
	# end


end
