class AddMenuToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :menu_id, :integer
  end
end
