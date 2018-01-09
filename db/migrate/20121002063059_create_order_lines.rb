class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.integer :dish_id
      t.integer :user_id
      t.float :price

      t.timestamps
    end
  end
end
