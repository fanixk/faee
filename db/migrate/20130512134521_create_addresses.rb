class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :label
      t.string :street_name
      t.integer :street_num
      t.string :region
      t.string :comment
      t.integer :user_id

      t.timestamps
    end
    add_index :addresses, :user_id
  end
end
