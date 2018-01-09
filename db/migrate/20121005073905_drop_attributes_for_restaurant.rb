class DropAttributesForRestaurant < ActiveRecord::Migration
  def up
    remove_column :restaurants, :is_online_order
    remove_column :restaurants, :is_delivery
    remove_column :restaurants, :is_franchise
  end

  def down
  end
end
