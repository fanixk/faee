class AddZipcodeToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :zipcode, :string
  end
end
