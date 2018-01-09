# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    name "MyString"
    description "MyString"
    open_hours "MyString"
    address "MyString"
    phone "MyString"
    email "MyString"
    is_active false
  end
end
