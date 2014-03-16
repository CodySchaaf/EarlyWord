EarlyBird::Application.routes.draw do
  #devise_for :users, except: [:registrations]
  devise_for :users, :controllers => { :registrations => 'users' }

  root 'weathers#new'

  resources :weathers, only: [:new, :create, :show]




end
