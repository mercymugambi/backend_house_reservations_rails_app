Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users
      resources :users, only: [:index]
      resources :houses, only: %i[index create new show destroy] do
        collection do
          get 'unique_cities', to: 'houses#unique_cities'
        end  
        resources :reservations, only: %i[index create new show destroy]
      end
    end
  end
end
