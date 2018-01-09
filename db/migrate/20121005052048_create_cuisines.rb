class CreateCuisines < ActiveRecord::Migration
  def change
    create_table :cuisines do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
