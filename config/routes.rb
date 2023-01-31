Rails.application.routes.draw do
  root "user#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

#   get "/users/sign_up", to: "users#new"

devise_scope :user do
  root to: 'devise/registrations#new'
end

devise_scope :user do
  delete 'logout', to: 'devise/sessions#destroy'
end

   resources :users do
     resources :posts ,only: [:index,:show,:edit,:new,:create]
   end

   resources :posts do
     resources :comments, :likes , only: [:new,:create]
   end
 end
