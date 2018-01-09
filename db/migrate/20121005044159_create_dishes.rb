class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.boolean :is_hot
      t.boolean :is_vegetarian
      t.float :price
      t.string :primary_image
      t.string :type

      t.timestamps
    end
  end
end
