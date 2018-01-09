# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    restaurant_id 1
    user_id 1
    table_id 1
    price 1.5
    tax 1.5
    tip 1.5
    total 1.5
    status "MyString"
    waiter_id 1
  end
end
