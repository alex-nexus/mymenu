class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :restaurant_id
      t.integer :user_id
      t.integer :table_id
      t.float :price
      t.float :tax
      t.float :tip
      t.float :total
      t.string :status
      t.integer :waiter_id

      t.timestamps
    end
  end
end
