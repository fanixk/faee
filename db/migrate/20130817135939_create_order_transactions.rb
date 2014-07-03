class CreateOrderTransactions < ActiveRecord::Migration
  def change
    create_table :order_transactions do |t|
      t.string :action
      t.integer :amount
      t.integer :order_id
      t.string :authorization
      t.string :message
      t.text :params
      t.boolean :success

      t.timestamps
    end
    add_index :order_transactions, :order_id
  end
end
