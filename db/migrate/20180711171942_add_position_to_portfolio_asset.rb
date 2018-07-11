class AddPositionToPortfolioAsset < ActiveRecord::Migration[5.2]
  def change
    add_column :portfolio_assets, :position, :string
  end
end
