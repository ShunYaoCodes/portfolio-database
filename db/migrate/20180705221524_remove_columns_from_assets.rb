class RemoveColumnsFromAssets < ActiveRecord::Migration[5.2]
  def change
    remove_column :assets, :company
    remove_column :assets, :exchange
    remove_column :assets, :sector
    remove_column :assets, :closing_price
  end
end
