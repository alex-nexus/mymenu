class RenameDishTypes < ActiveRecord::Migration
  def up
    rename_table :dish_types, :dish_categories
  end

  def down
  end
end
