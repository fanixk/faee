class AddPhoneToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :phone, :bigint
  end
end
