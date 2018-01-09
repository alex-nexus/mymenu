class CreateRestaurantToUser < ActiveRecord::Migration
  def up
    create_table :restaurant_to_users do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :type
 
      t.timestamps
    end
  end

  def down
    drop_table :products
  end
end
