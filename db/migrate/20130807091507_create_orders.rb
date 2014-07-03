class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :address_id
      t.string :pay_type

      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :address_id
  end
end
