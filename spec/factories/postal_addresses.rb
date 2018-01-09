# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :postal_address do
    street ""
    locality ""
    region ""
    country ""
    postal_code "MyString"
    latitude 1.5
    longitude 1.5
  end
end
