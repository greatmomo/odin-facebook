Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "posts#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", registrations: 'users/registrations' }

  resources :users, only: [:index]

  resources :posts
  
  resources :friend_request, only: [:create, :index] do
    member do
      post 'confirm'
      delete 'delete'
    end
  end

  resources :likes, only: [:create] do
    member do
      delete 'delete'
    end
  end
end
