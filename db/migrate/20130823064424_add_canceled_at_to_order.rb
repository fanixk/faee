class AddCanceledAtToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :canceled_at, :datetime
  end
end
