class AddGoogleIdToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :google_id, :string
  end
end
