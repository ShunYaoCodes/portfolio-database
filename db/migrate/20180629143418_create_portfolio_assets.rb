class CreatePortfolioAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolio_assets do |t|
      t.integer :user_id
      t.integer :asset_id

      t.timestamps
    end
  end
end
