class Watchlist < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :asset, optional: true
end
