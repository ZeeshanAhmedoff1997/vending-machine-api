class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.decimal :quantity, default: 0
      t.decimal :cost, default: 0
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
