class Cuisine < ActiveRecord::Base
  attr_accessible :name, :parent_id
  def self.refresh
    cuisines_in_db = Cuisine.all.map(&:name).uniq

    file = File.new("config/cuisines.txt", "r")
    cuisines_in_file=[]
    while (line = file.gets)
      cuisine = line.downcase.strip!
      cuisines_in_file.push(cuisine)
    end
    cuisines_in_file = cuisines_in_file.uniq
    puts "total count: #{cuisines_in_file.count}"

    ##

    #add
    cuisines_to_be_added = (cuisines_in_file - cuisines_in_db).select{|t|!t.nil?}.uniq
    cuisines_to_be_added.each {|cuisine| Cuisine.find_or_create_by_name(cuisine)}
    puts "aad:#{cuisines_to_be_added.inspect}"

    #delete
    cuisines_to_be_deleted = (cuisines_in_db -cuisines_in_file).uniq
    cuisines_to_be_deleted.each {|cuisine| Cuisine.delete_all(:name => cuisine)}
    puts "delete:#{cuisines_to_be_deleted.inspect}"

    #populate file
    file = File.open("config/cuisines.txt", "w")
    Cuisine.all.map(&:name).sort.each {|cuisine| file.puts cuisine}
    file.close
  end
end
