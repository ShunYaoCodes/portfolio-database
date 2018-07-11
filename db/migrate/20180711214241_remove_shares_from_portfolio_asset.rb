class RemoveSharesFromPortfolioAsset < ActiveRecord::Migration[5.2]
  def change
    remove_column :portfolio_assets, :shares, :integer
  end
end
