Rails.application.routes.draw do
  resources :houses
  resources :reservations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'root#index'

  namespace :api do
    namespace :v1 do
      get 'random_greeting', to: 'messages#random_greeting'
    end
  end
end
