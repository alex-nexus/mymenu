class AddTableSeqToRestaurantToUser < ActiveRecord::Migration
  def change
    add_column :restaurant_to_users, :table_seqeucne, :integer
    add_column :restaurant_to_users, :arrive_at, :datetime
    add_column :restaurant_to_users, :leave_at, :datetime
  end
end
