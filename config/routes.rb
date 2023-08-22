Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users
      resources :users, only: [:index]
      resources :houses, only: %i[index create new show destroy] do
        resources :reservations, only: %i[index create new show destroy]
      end
    end
  end
end
