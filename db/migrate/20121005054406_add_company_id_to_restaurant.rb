class AddCompanyIdToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :company_id, :integer
  end
end
