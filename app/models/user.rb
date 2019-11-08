class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  
  has_many :search_histories
  has_many :watchlists
  has_many :portfolio_assets
end
