FactoryBot.define do
  factory :product do
    name {"Adidas"}
    price {5000000.0}
    quantity_in_stock {rand(50..200)}
    description {Faker::Lorem.sentence(word_count: 5)}
  end
end
