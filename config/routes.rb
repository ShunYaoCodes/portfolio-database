Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :assets, only: [:index, :show, :create, :update, :destroy]
      resources :portfolio_assets, only: [:index, :show, :create, :update, :destroy]
      resources :watchlists, only: [:index, :show, :create, :update, :destroy]
      resources :search_histories, only: [:index, :show, :create, :destroy]
      resources :users, only: [:index, :show, :create, :update, :destroy]
      post '/sessions/', to: 'sessions#create'

      resources :users do
        resources :watchlists
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
