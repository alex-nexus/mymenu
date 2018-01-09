class AddAttributeToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :is_online_order, :boolean
    add_column :restaurants, :is_delivery, :boolean
  end
end
