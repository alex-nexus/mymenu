class PostalAddress < ActiveRecord::Base
  attr_accessible :country, :locality, :postal_code, :region, :street, :latitude, :longitude

  validates_presence_of :country, :locality, :postal_code, :region, :street
end
