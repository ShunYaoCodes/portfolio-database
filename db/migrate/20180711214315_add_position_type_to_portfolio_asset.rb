class AddPositionTypeToPortfolioAsset < ActiveRecord::Migration[5.2]
  def change
    add_column :portfolio_assets, :position_type, :string
  end
end
