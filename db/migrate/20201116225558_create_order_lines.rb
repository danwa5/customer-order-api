class CreateOrderLines < ActiveRecord::Migration[5.2]
  def change
    create_table :order_lines do |t|
      t.references :order, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false
      t.string :product_name
      t.decimal :quantity, precision: 8, scale: 2
      t.string :unit
      t.timestamps null: false
    end
  end
end
