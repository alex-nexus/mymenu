class AddAddress2ToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :city, :string
    add_column :restaurants, :region, :string
    add_column :restaurants, :country, :string
    add_column :restaurants, :postal_code, :string
  end
end
