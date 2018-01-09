class User < ActiveRecord::Base
  rolify
  acts_as_gmappable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :latitude, :longitude

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  def manage_restaurants
    return Restaurant.unscoped if self. has_role?(:overcomer)
    Restaurant.with_role(:owner, self)
  end

  def manage_restaurant_dishes
    self.manage_restaurants.map {|r| r.dishes}.uniq
  end
end
