class PortfolioAsset < ApplicationRecord
  belongs_to :user
  belongs_to :asset
end
