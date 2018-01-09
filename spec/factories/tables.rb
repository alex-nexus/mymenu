# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :table do
    name "MyString"
    sequence 1
    num_seats 1
    shape "MyString"
  end
end
