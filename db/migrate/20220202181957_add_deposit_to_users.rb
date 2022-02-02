class AddDepositToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deposit, :decimal, default: 0.0
  end
end
