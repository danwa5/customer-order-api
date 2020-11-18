class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :list_price, precision: 8, scale: 2, null: false
      t.timestamps null: false
    end
  end
end
