class Company < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :restaurants, :inverse_of => :company
end
