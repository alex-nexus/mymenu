class CreateRestaurantToTags < ActiveRecord::Migration
  def up
    create_table :restaurant_to_tags do |t|
      t.integer :restaurant_id
      t.integer :tag_id
    end
  end

  def down
  end
end
