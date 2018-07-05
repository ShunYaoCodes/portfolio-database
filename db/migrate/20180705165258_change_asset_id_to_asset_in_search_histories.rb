class ChangeAssetIdToAssetInSearchHistories < ActiveRecord::Migration[5.2]
  def change
    remove_column :search_histories, :asset_id
    add_column :search_histories, :asset, :string
  end
end
