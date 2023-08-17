Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'root#index'

  resources :houses, only: %i[index show new create destroy] do
    resources :reservations, only: %i[index show new create destroy]
  end

  namespace :api do
    namespace :v1 do
      get 'random_greeting', to: 'messages#random_greeting'
    end
  end
end
