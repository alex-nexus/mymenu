class CreateDishToTags < ActiveRecord::Migration
  def up
    create_table :dish_to_tags do |t|
      t.integer :dish_id
      t.integer :tag_id
    end
  end

  def down
  end
end
