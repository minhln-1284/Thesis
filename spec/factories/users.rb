FactoryBot.define do
  factory :user do
    name {"Luong Minh"}
    email {"minh-#{rand(1..10)}@gmail.com"}
    phone {Faker::PhoneNumber.cell_phone}
    address {Faker::Address.street_address}
    password {"foobar"}
    password_confirmation {"foobar"}
    role { rand(0..1) }
  end
end
