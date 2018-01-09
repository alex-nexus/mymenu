# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_line do
    dish_id 1
    user_id 1
    price 1.5
  end
end
