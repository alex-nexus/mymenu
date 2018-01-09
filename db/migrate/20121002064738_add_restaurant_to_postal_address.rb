class AddRestaurantToPostalAddress < ActiveRecord::Migration
  def change
    add_column :postal_addresses, :restaurant_id, :integer
  end
end
