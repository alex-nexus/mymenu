class Table < ActiveRecord::Base
  attr_accessible :name, :num_seats, :restaurant_id, :sequence, :shape
  
  has_many :users, :through => 'TableToUser'
end
