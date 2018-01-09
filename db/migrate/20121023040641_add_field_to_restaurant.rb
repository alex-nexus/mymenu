class AddFieldToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :status, :string
    add_column :restaurants, :street_address, :string
    add_column :restaurants, :google_ref, :string
    add_column :restaurants, :google_rating, :float
  end
end
