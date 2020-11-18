class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.timestamps null: false
    end
  end
end