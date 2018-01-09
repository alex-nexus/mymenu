class RestaurantsController < ApplicationController
  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @restaurants }
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurant }
    end
  end

  def map
    #query
    query_params = {}
    query_params['name'] = params[:q].strip unless params[:q].nil? || params[:q].strip ==''
    query_params['city'] = params[:city].strip unless params[:city].nil? || params[:city].strip ==''
    query_params['region'] = params[:region].strip unless params[:region].nil? || params[:region].strip ==''
    query = query_params.map{|k,v| k+" ILIKE '%#{v}%'"}.join(' AND ') unless query_params.empty? 

    #use current location is no query found
    if query.nil?
      lat = cookies['latitude'].to_f.round(1)
      log = cookies['longitude'].to_f.round(1)
      u = User.new
      u.latitude = lat
      u.longitude = log      
      restaurants = Restaurant.near([lat, log], 1).limit(1000) #.order("distance asc")
    else
      restaurants = Restaurant.where(query).limit(1000) #.order("distance asc")
    end
    @markers = ([u]+restaurants).to_gmaps4rails
    #@markers = restaurants.to_gmaps4rails
    @markers.inspect
  end
end
