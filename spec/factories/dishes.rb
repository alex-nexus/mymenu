# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dish do
    name "MyString"
    description "MyString"
    is_hot false
    is_vegetarian false
    price 1.5
    primary_image "MyString"
    type ""
  end
end
