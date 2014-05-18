EarlyWord::Application.routes.draw do
	#devise_for :users, except: [:registrations]
	devise_for :users, :controllers => { :registrations => 'registrations' }

	root 'weathers#new'

	resources :weathers, only: [:new, :create, :show, :destroy]
	resources :widgets, only: [:create, :show, :destroy]

end
