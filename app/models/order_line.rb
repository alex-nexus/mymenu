class OrderLine < ActiveRecord::Base
  attr_accessible :price
  
  belongs_to :user
  belongs_to :dish
end
