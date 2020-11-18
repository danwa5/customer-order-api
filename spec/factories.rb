FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
  end

  factory :order do
    association :customer
    order_date { Date.today }
  end

  factory :order_line do
    association :order
    association :product
    quantity { Faker::Number.between(from: 1, to: 5) }
  end

  factory :product do
    name { Faker::Commerce.product_name }
    list_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end

  factory :category
end
