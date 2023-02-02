Rails.application.routes.draw do
  root "users#index"
  devise_for :users, :controllers => {:registrations => "registrations"}



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

#   get "/users/sign_up", to: "users#new"

   resources :users, only: [:index,:show] do
     resources :posts ,only: [:index,:show,:edit,:new,:create]
   end

   resources :posts, only: [:index,:destroy] do
     resources :comments, :likes , only: [:new,:create,:destroy]
   end

   namespace :api do
    resources :users do
      resources :posts, only: [:index,:show] do
        resources :comments
      end
    end
   end
 end
