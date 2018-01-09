class CreateDishTypes < ActiveRecord::Migration
  def change
    create_table :dish_types do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
