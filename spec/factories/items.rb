FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    category_id { 1 }
    status_id { 1 }
    shipping_fee_id { 1 }
    prefecture_id { 1 }
    delivery_time_id { 1 }
    price { 1 }
    user { nil }
  end
end
