FactoryBot.define do
  factory :order do
    amount { rand(50.0..100.0) }
    status { rand(0..1) }
    user { create(:user) }
  end
end
