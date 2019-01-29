Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :assets, only: [:index, :show, :create, :update, :destroy]
      resources :portfolio_assets, only: [:index, :show, :create, :update, :destroy]
      resources :watchlists, only: [:index, :show, :create, :update, :destroy]
      resources :search_histories, only: [:index, :show, :create, :destroy]
      resources :users, only: [:index, :show, :create, :update, :destroy]

      get '/users/:user_id/search_histories', to: 'users#user_search_histories'
      get '/users/:user_id/watchlists', to: 'users#user_watchlists'
      get '/users/:user_id/portfolio_assets', to: 'users#portfolio_assets'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
