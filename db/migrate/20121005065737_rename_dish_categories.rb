class RenameDishCategories < ActiveRecord::Migration
  def up
    rename_table :dish_categories, :dish_tags
    remove_column :dish_tags, :parent_id 
  end

  def down
  end
end
