class ChangeUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.rename :username, :email
      t.rename :name, :first_name
      t.string :last_name
    end
  end
end
