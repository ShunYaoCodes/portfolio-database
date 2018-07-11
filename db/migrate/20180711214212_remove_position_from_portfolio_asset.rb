class RemovePositionFromPortfolioAsset < ActiveRecord::Migration[5.2]
  def change
    remove_column :portfolio_assets, :position, :string
  end
end
