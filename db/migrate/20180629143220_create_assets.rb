class CreateAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :assets do |t|
      t.string :symbol
      t.string :company
      t.string :exchange
      t.string :sector
      t.decimal :closing_price

      t.timestamps
    end
  end
end
