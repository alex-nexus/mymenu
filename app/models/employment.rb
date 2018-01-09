class Employment < ActiveRecord::Base
  attr_accessible :restaurant_id, :user_id, :type
  
  belongs_to :restaurant
  belongs_to :staff, :class_name => 'User', :foreign_key => 'user_id'
end
