# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dish_type do
    name "MyString"
    parent_id 1
  end
end
