require 'resque-loner'

class Crawler
  include Resque::Plugins::UniqueJob
  @queue = :restaurant_queue

  REQUEUE_MAX = 1
  RADIUS = 3000 #3000 meters = 3   km

  CAR_TYPES = ['car_dealer', 'car_rental', 'car_repair', 'car_wash']

  SERVICE_TYPES = [ 'beauty_salon','florist', 'hair_care','locksmith','spa']

  FOOD_TYPES = ['bakery','bar','food', 'health','grocery_or_supermarket','night_club', 'pharmacy','restaurant']

  PROFESSIONAL_SERVICE_TYPES = ['accounting', 'dentist','doctor','electrician','general_contractor','insurance_agency',
    'lawyer','physiotherapist','plumber','real_estate_agency','roofing_contractor']

  STORE_TYPES = ['bicycle_store', 'clothing_store', 'convenience_store', 'department_store', 'electronics_store', 'furniture_store',
    'hardware_store','home_goods_store','jewelry_store','liquor_store', 'pet_store','shoe_store','shopping_mall', 'store',]

  CUISINES = ["afghan", "ethiopian", "middle eastern", "african", "filipino", "moroccan", "american",
    "french", "nepalese", "argentinean", "german", "pakistani", "asian", "greek", "persian", "belgian",
    "hawaiian", "peruvian", "brazilian", "indian", "polish", "british", "indonesian", "russian", "burmese",
    "irish", "south american", "cajun & creole", "italian", "southern", "cambodian", "dutch", "japanese",
    "southwestern", "cantonese", "korean", "spanish", "caribbean", "kosher", "szechwan", "chinese",
    "latin american", "taiwanese", "colombian", "lebanese", "tex-mex", "cuban", "malaysian", "thai",
    "mandarin", "turkish", "egyptian", "mediterranean", "vietnamese", "el salvadoran", "canadian",
    "scandinavian", "danish", "icelandic", "norwegian"]

  KEY_CUISINES = ["afghan", "ethiopian", "middle eastern", "african", "filipino", "moroccan", "american",
    "french", "nepalese", "argentinean", "german", "pakistani", "asian", "greek", "persian", "belgian",
    "hawaiian", "peruvian", "brazilian", "indian", "polish", "british", "indonesian", "russian", "burmese",
    "irish", "south american", "cajun & creole", "italian", "southern", "cambodian", "dutch", "japanese",
    "southwestern", "cantonese", "korean", "spanish", "caribbean", "kosher", "szechwan", "chinese",
    "latin american", "taiwanese", "colombian", "lebanese", "tex-mex", "cuban", "malaysian", "thai",
    "mandarin", "turkish", "egyptian", "mediterranean", "vietnamese", "el salvadoran", "canadian",
    "scandinavian", "danish", "icelandic", "norwegian"]

  def self.perform(query='', location='', pagetoken=nil, requeue=0)
    restaurant_crawler = GoogleApi::Restaurant::Crawler.new
    restaurant_crawler.perform(query, location, pagetoken, requeue)
  end

  def perform(query, location, pagetoken=nil, requeue=0)
    @query = query
    @location = location
    @pagetoken = pagetoken
    @requeue = requeue.to_i
    self.invoke
    self.process
  end

  def invoke
    params = {'key' => Rails.configuration.google_api.api_key,
      'query' => @query,
      #'location' => @location,
      'radius' => GoogleApi::Restaurant::Crawler::RADIUS.to_s,
      'types' => 'restaurant|bar|cafe',
      'sensor' => 'false',
      'rankBy' => 'distance'
    }
    params['pagetoken'] = @pagetoken unless @pagetoken.nil?
    param_string = params.map{|k,v| k+'='+v }.join('&') #params.to_param
    #uri = URI(Rails.configuration.google_api.place_serach_api_url+param_string)
    #uri = URI(Rails.configuration.google_api.place_text_serach_api_url+param_string)
    url = Rails.configuration.google_api.place_text_serach_api_url+param_string
    puts url.inspect
    cmd = %[curl "#{url}"]
    @response = JSON.parse(`#{cmd}`)
  end

  def process
    raise @response['status'] unless @response['status'] == 'OK'
    puts @response['results'].count

    #1. save restaurant
    @response['results'].each do |entry|
      google_id = entry['id']

      r = Mongo::Restaurant.where(:google_id => google_id).first
      next unless r.nil?

      r = Mongo::Restaurant.find_or_create_by(:google_id => google_id)
      r.google_ref = entry['reference']
      r.name = entry['name']
      r.google_types = entry['types']
      r.google_rating = entry['rating']
      r.images = entry['photos']
      r.latitude = entry['geometry']['location']['lat']
      r.longitude = entry['geometry']['location']['lng']
      r.address = entry['formatted_address'] unless entry['formatted_address'].nil?
      r.save!
      r.accept! if r.new?
      puts r.name
    end

    #2. queue the next paginated job
    if @requeue<=REQUEUE_MAX && !@response['next_page_token'].nil?
      @requeue+=1
      puts "#{@query} #{@location} is re-queued #{@requeue} times"
      Resque.enqueue(GoogleApi::Restaurant::Crawler, @query, @location, @response['next_page_token'], @requeue)
    end
  end
end
