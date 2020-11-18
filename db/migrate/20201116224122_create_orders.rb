class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true, null: false
      t.datetime :order_date, null: false
      t.string :status
      t.timestamps null: false
    end
  end
end
