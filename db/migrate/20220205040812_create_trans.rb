class CreateTrans < ActiveRecord::Migration[6.0]
  def change
    create_table :trans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :spent, null: false

      t.timestamps
    end
  end
end
