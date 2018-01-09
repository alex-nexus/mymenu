# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant_table do
    restaurant_id 1
    name "MyString"
    sequence 1
    num_seats 1
    shape "MyString"
  end
end
