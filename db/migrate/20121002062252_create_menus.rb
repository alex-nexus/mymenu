class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :type
      t.boolean :is_active

      t.timestamps
    end
  end
end
