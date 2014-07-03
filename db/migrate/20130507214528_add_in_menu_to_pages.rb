class AddInMenuToPages < ActiveRecord::Migration
  def change
    add_column :pages, :in_menu, :boolean
  end
end
