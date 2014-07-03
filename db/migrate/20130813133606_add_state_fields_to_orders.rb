class AddStateFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string
    add_column :orders, :purchased_at, :datetime
    add_column :orders, :shipped_at, :datetime
    add_column :orders, :delivered_at, :datetime
  end
end
