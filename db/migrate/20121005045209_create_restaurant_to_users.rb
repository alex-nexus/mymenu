class CreateRestaurantToUsers < ActiveRecord::Migration
  def change
    create_table :restaurant_to_users do |t|
      t.integer :restaurant_id
      t.integer :table_id
      t.integer :user_id
      t.string :type

      t.timestamps
    end
  end
end
