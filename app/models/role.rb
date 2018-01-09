class Role < ActiveRecord::Base
  scopify
  ROLES = [:overcomer, :owner, :customer]
  RESOURCE_TYPES = [:restaurant]
  attr_accessible :name

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  scope :own_restaurants, where(:name => :owner, :resource_type => :restaurant)
end
