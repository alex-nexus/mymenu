source 'https://rubygems.org'
gem 'rails', '3.2.8'
gem 'pg'
gem "mongoid", "~> 3.0.0"

#engine
#gem 'rails_admin'
gem 'activeadmin'
gem "devise", ">= 2.1.2"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

#auth 
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"

#ui
gem 'jquery-rails'
gem "bootstrap-sass", ">= 2.1.0.0"
gem 'haml'
gem 'kaminari'
gem 'simple_form'
gem 'country-select'


#search
#gem "meta_search",    '>= 1.1.0.pre'
gem 'tire'

#job
gem 'resque', '>= 1.20.0', :require => 'resque/server'
gem 'resque-scheduler', '2.0.0', :require => 'resque_scheduler'
gem 'resque-loner'

#api
gem 'google_drive'
gem 'gmaps4rails'

#geo
gem "geocoder"

#seo
gem 'seo_helper'

#performance
#gem 'newrelic_rpm'
gem 'country-select'
gem 'workflow'

#test
group :development, :test do
  gem "rspec-rails", ">= 2.11.0", :group => [:development, :test]
  gem "capybara", ">= 1.1.2", :group => :test
  gem "email_spec", ">= 1.2.1", :group => :test
  gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false
  gem "database_cleaner", ">= 0.8.0", :group => :test
  gem "launchy", ">= 2.1.2", :group => :test
  gem "factory_girl_rails", ">= 4.1.0", :group => [:development, :test]
  
  gem 'spork'
  gem 'forgery'
  gem 'pry'
  gem 'simplecov'
end