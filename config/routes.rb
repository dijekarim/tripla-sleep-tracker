require "sidekiq/web"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount Sidekiq::Web => '/sidekiq'

  get 'up' => 'rails/health#show'

  namespace :api do
    namespace :v1 do
      resources :sleep_records, only: [:index] do
        collection do
          post :clock_in
          post :clock_out
          get :followees_sleep_records
        end
      end
      resources :follows, only: [:index, :create, :destroy]
    end
  end  
end
