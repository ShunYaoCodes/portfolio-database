class AddInvestmentAmountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :investment_amount, :decimal, precision: 19, scale: 4
  end
end
