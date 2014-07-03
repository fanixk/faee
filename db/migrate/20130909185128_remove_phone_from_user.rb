class RemovePhoneFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :phone
  end

  def down
    add_column :users, :phone, :bigint
  end
end
