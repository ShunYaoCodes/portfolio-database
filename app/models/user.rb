class User < ApplicationRecord
  has_secure_password
  
  has_many :search_histories
  has_many :watchlists
  has_many :portfolio_assets
end
