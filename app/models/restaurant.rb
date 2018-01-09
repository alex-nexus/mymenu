class Restaurant < ActiveRecord::Base
  include Workflow
  acts_as_gmappable
  resourcify
      
  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode 
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode       

  attr_accessible :email, :phone, :name, :description, :primary_image,  
    :open_hours, :company_id, 
    :address, :street_address, :city, :region, :country, :postal_code, 
    :latitude, :longitude, 
    :status, :is_active, :url, 
    :google_rating, :google_ref, :google_id
    
  belongs_to :company, :inverse_of => :restaurants
  has_one :postal_address

  has_many :tables
  has_many :dishes
  has_and_belongs_to_many :tags, :join_table => "restaurant_to_tags"

  validates_presence_of :name, :address
  #default_scope :order => 'name ASC'

  #workflow
  workflow do
    state :new do #to be pre-processed
      event :accept, :transitions_to => :accepted
      event :inactivate, :transitions_to => :inactive      
    end

    state :accepted do #to be processed
      event :extract,  :transitions_to => :extracted
    end

    state :extracted do #to be processed
      event :activate, :transitions_to => :active
    end

    state :active do
      event :deactivate, :transitions_to => :inactive
    end
    
    state :inactive    
  end
  
  def gmaps4rails_title
    self.name
  end
  
  def gmaps4rails_address
    self.address
  end
  
  def gmaps4rails_infowindow
    a = []
    a << address unless address.nil?
    a << city unless city.nil?
    a << region unless region.nil?
    a << country unless country.nil?
    a << postal_code unless postal_code.nil?
    a.join(', ')    
  end
  
  def full_street_address
    address+', '+city+', '+region+', '+country+', '+postal_code
  end    
end
