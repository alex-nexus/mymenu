class AddIsFranchiseToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :is_franchise, :boolean
  end
end
