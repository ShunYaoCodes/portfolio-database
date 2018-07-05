class ChangeAssetToAssetIdInSearchHistories < ActiveRecord::Migration[5.2]
  def change
    remove_column :search_histories, :asset
    add_column :search_histories, :asset_id, :integer
  end
end
