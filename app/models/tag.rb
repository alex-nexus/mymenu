#Alcohol Late Night BagelsLow CarbBakery & Pastries
#Low FatBarbecueLunch SpecialsBreakfast
#NoodlesBurgersPastaCalifornianPitasCalzones
#PizzaCheesesteaksPub FoodChickenRibsClassicSalads
#Coffee & TeaSandwichesCrepesSeafoodDeli Food
#Smoothies & JuicesDessertsSoul FoodDim SumSoupsEclectic
#SteakFine DiningSubsGrillSushiGyrosTapas
#HealthyVeganHoagiesVegetarianHot DogsWingsIce
#CreamWraps
#Kids Menu
class Tag < ActiveRecord::Base
  attr_accessible :name, :type

  has_and_belongs_to_many :restaurants, :join_table => "restaurant_to_tags"
  has_and_belongs_to_many :dishes, :join_table => "dish_to_tags"
  
  def self.refresh
    tags_in_db = Tag.all.map(&:name).uniq

    file = File.new("config/tags.txt", "r")
    tags_in_file=[]
    while (line = file.gets)
      line = line.downcase
      tag = line.strip!
      tags_in_file.push(tag)
    end
    tags_in_file = tags_in_file.uniq
    puts "total count: #{tags_in_file.count}"

    ##

    tags_to_be_added = (tags_in_file - tags_in_db).select{|t|!t.nil?}.uniq
    puts "aad:#{tags_to_be_added.inspect}"
    
    tags_to_be_deleted = (tags_in_db -tags_in_file).uniq
    puts "delete#{tags_to_be_deleted.inspect}"

    #add
    tags_to_be_added.each do |tag|
      StoreTag.find_or_create_by(:value => tag)
    end

    #delete
    tags_to_be_deleted.each do |tags|
      StoreTag.delete_all(:value => tags)
    end

    ##

    file = File.open("config/tags.txt", "w")
    StoreTag.all.order_by(:value => :asc).each do |tag|
      file.puts tag.value
    end
    file.close    
  end
end

