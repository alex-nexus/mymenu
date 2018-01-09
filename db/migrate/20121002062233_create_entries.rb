class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.string :description
      t.string :primary_image
      t.float :price
      t.string :type
      t.boolean :is_hot
      t.boolean :is_vegetarian

      t.timestamps
    end
  end
end
