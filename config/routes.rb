Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", registrations: 'users/registrations' }
  resources :users, only: [:index]
  resources :friend_request, only: [:index]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"

  patch '/user/:id/friendRequest', to: 'users#index', as: 'friendRequest'
  


end
