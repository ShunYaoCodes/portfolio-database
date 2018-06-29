Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :assets, only: [:index, :show, :create, :update, :delete]
      resources :portfolio_assets, only: [:index, :show, :create, :update, :delete]
      resources :watchlists, only: [:index, :show, :create, :update, :delete]
      resources :search_histories, only: [:index, :show, :create, :delete]
      resources :users, only: [:index, :show, :create, :update, :delete]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
