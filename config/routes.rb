EarlyBird::Application.routes.draw do
  devise_for :users
  root 'weather#new'


end
