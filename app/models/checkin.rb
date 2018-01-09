class Checkin < ActiveRecord::Base
  attr_accessible :restaurant_id, :table_id, :type, :user_id, :table_sequence, :arrive_at, :leave_at
  
  belongs_to :restaurant
  belongs_to :user  
end
