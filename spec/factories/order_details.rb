FactoryBot.define do
  factory :orderdetail do
    quantity { rand(1..5) }
    price { rand(50.0..100.0) }
    order { create(:order) }
    product { create(:product) }
  end
end
