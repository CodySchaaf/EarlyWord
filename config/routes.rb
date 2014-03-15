EarlyBird::Application.routes.draw do
  devise_for :users
  root 'weather#new'

  resources :weather, only: [:new, :create, :show]


end
