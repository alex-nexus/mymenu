# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant_to_user do
    restaurant_id 1
    table_id 1
    user_id 1
    type ""
    table_sequence 1 
  end
end
