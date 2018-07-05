class Asset < ApplicationRecord
  has_many :watchlists
  has_many :portfolio_assets
end
