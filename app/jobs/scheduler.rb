class Scheduler
  @queue = :restaurant_queue
  def self.perform
    cities = ['DAVIS', 'SAN FRANCISCO', 'BURLINGAME', 'MILLBRAE', 'SAN MATEO', 'SAN BRUNO', 'SOUTH SAN FRANCISCO',
      'SAN CARLOS', 'PALO ALTO', 'MOUNTAIN VIEW', 'REDWOOD CITY', 'MENLO PARK', 'HILLSDALE', 'FOSTER CITY', 'BELMONT']

    queries = Locality.where(:state=>'CA', :latitude.gt => 36).map do |l|
      GoogleApi::Restaurant::Crawler::CUISINES.map do |cuisine|
        CGI.escape([cuisine, l.name, l.state].join(' '))
      end
    end

    queries.flatten.uniq.each do |query|
      puts query
      Resque.enqueue(GoogleApi::Restaurant::Crawler, query)
    end

  #extract those which are accepted
  # count = 0
  # Mongo::Restaurant.where(:status => 'accepted').each do |r|
  #Resque.enqueue(GoogleApi::Restaurant::Extractor, r.google_ref)
  # GoogleApi::Restaurant::Extractor::perform(r.google_ref)
  # count+=1
  # puts count
  # end
  end
end
