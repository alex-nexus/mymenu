class RenameDishTags < ActiveRecord::Migration
  def up
    rename_table :dish_tags, :tags
  end

  def down
  end
end
