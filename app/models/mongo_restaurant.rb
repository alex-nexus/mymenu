class MongoRestaurant
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'restaurants'

  paginates_per 10
  #url
  field :url, :type => String
  field :google_ref, :type => String
  field :google_id, :type => String

  #metadata
  field :name, :type => String
  field :description, :type => String
  field :keywords, :type => Array
  field :tags, :type => Array

  #google
  field :google_types, :type => Array
  field :google_rating, :type => Float

  #address
  field :address, :type => String
  field :street_address, :type => String #The street address. For example, 1600 Amphitheatre Pkwy.
  field :city, :type => String  # The locality. For example, Mountain View.
  field :region, :type => String #  The region. For example, CA.
  field :postal_code, :type => String # The postal code. For example, 94043.
  field :country, :type => String   # http://en.wikipedia.org/wiki/ISO_3166-1
  field :latitude, :type => Float
  field :longitude, :type => Float

  #image
  field :images, :type => Array

  #hour
  field :opening_hours_raw, :type => String
  field :opening_hours, :type => Array #Weekly opening hours for a business.
  #- Days are specified as : Mo, Tu, We, Th, Fr, Sa, Su.
  #- Times are specified using 24:00 time. For example, 3pm is specified as 15:00.
  #- An example: "Tu,Th 16:00-20:00"
  #- If a business is open 7 days a week, then it can be specified "Mo-Su"

  field :email, :type => String
  field :phone, :type => String

  field :status, :type => String

  #address
  field :longitude, :type => Float
  field :latitude, :type => Float
  #migrate those which are extracted
  def self.migrate_to_db
    count = 0
    MongoRestaurant.where(:status => 'extracted').each do |mr|
      r = Restaurant.find_or_initialize_by_google_id(mr.google_id)

      #basic
      r.name = mr.name
      r.is_active = 1

      #contact
      r.url = mr.url
      r.phone = mr.phone
      
      r.address = mr.address
      r.city = mr.city
      r.region = mr.region
      r.country = mr.country
      r.postal_code = mr.postal_code
            
      #location
      r.latitude = mr.latitude
      r.longitude = mr.longitude

      count+=1
      puts count
      r.save!      
    end
  end
end