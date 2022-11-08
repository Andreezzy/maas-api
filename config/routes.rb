Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users
      resources :companies
      resources :sessions, only: :create
      get :check_jwt, to: 'api#check_jwt'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
