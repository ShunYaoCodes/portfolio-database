class AddSharesToPortfolioAsset < ActiveRecord::Migration[5.2]
  def change
    add_column :portfolio_assets, :shares, :integer
  end
end
