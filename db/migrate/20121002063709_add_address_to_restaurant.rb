class AddAddressToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :postal_address_id, :integer
    add_column :restaurants, :primary_image, :string
  end
end
