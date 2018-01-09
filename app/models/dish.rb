class Dish < ActiveRecord::Base
  attr_accessible :description, :name, :price, :primary_image, :type, :restaurant_id
  
  belongs_to :restaurant  
  has_and_belongs_to_many :tags, :join_table => "dish_to_tags"  
end
