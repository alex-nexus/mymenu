class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :description
      t.string :open_hours
      t.string :address
      t.string :phone
      t.string :email
      t.boolean :is_active

      t.timestamps
    end
  end
end
