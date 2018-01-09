class Order < ActiveRecord::Base
  attr_accessible :price, :status, :table_id, :tax, :tip, :discount, :total
  
  belongs_to :restaurant
  belongs_to :user  
end
