class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :restaurant_id
      t.string :name
      t.integer :sequence
      t.integer :num_seats
      t.string :shape

      t.timestamps
    end
  end
end
