require 'resque-loner'

class Extractor
  include Resque::Plugins::UniqueJob
  @queue = :restaurant_extract
  def self.perform(google_ref)
    restaurant_extractor = GoogleApi::Restaurant::Extractor.new
    restaurant_extractor.perform(google_ref)
  end

  def perform(google_ref)
    @google_ref = google_ref
    @restaurant = Mongo::Restaurant.where(:google_ref => google_ref).first
    self.invoke
    self.process if @response['status'] == 'OK'
  end

  def invoke
    params = {'key' => Rails.configuration.google_api.api_key,
      'reference' => @google_ref,
      'sensor' => 'false'
    }
    query = params.map{|k,v| k+'='+v }.join('&') #params.to_param
    uri = URI(Rails.configuration.google_api.place_detail_api_url+query)
    puts uri
    cmd = %[curl "#{uri}"]
    @response = JSON.parse(`#{cmd}`)
  end

  def process
    raise @response['status'] unless @response['status'] == 'OK'
    #1. update restaurant
    entry = @response['result']
    puts entry

    #basic
    @restaurant.name = entry['name'] unless entry['name'].nil?
    @restaurant.phone = entry['formatted_phone_number'] unless entry['formatted_phone_number'].nil?
    @restaurant.url = entry['website'] unless entry['website'].nil?

    @restaurant.google_types = entry['types']
    @restaurant.google_rating = entry['rating']
    @restaurant.images = entry['photos']
    @restaurant.latitude = entry['geometry']['location']['lat']
    @restaurant.longitude = entry['geometry']['location']['lng']

    #address
    @restaurant.address = entry['formatted_address'] unless entry['formatted_address'].nil?

    @restaurant.street_address = ''
    entry['address_components'].each do |ac|
      case ac['types'].first
      when 'street_number'
        @restaurant.street_address += ac['long_name']
      when 'route'
        @restaurant.street_address += ac['long_name']
      when 'locality'
        @restaurant.city = ac['long_name']
      when 'administrative_area_level_1'
        @restaurant.region = ac['long_name']
      when 'country'
        @restaurant.country = ac['long_name']
      when 'postal_code'
        @restaurant.postal_code = ac['long_name']
      end
    end

    #opening hours
    if !entry['opening_hours'].nil?
      @restaurant.opening_hours = entry['opening_hours']['periods']
    end

    @restaurant.extract! if @restaurant.accepted?
    @restaurant.save!
    puts @restaurant.inspect
  end
end
