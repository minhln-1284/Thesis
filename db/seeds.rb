require 'faker'

5.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "foobar"
  password_confirmation = "foobar"
  phone = Faker::PhoneNumber.cell_phone
  address = Faker::Address.street_address
  User.create!(name: name, phone: phone, address: address,
    password: password, password_confirmation: password_confirmation, email: email)
end

men = Category.create!(name: "Men")
woman = Category.create!(name: "Woman")
3.times do
  name = Faker::Emotion.noun
  cate1 = men.categories.new(name: name)
  cate1.save!
  name = Faker::Emotion.noun
  cate1.categories.create!(name: name)

  name = Faker::Movie.title
  cate2 = woman.categories.new(name: name)
  cate2.save!
  name = Faker::Movie.title
  cate2.categories.create!(name: name)
end

categories = Category.all
quantity_in_stock = 50
count = 1
categories.each do |category|
  rand(1..10).times do
    name = Faker::Nation.language + "-" + count.to_s
    product = category.products.create!(name: name, price: 50, quantity_in_stock: quantity_in_stock)
    product_image = product.product_images.create!
    product_image.image.attach(io: File.open("app/assets/images/ProductImage/product#{rand(1..5)}.jpg"), filename: "product#{rand(1..35)}.jpg")
  count += 1
  end
end


users = User.all
rand(1..5).times do
  status = rand(0..4)
  users.each { |user| user.orders.create!(status: status)}
end

users.each do |user|
  5.times do
    product_id = rand(1..30)
    comment = Faker::Lorem.sentence(word_count: 5)
    star = rand(1..5)
    user.ratings.create!(comment: comment, star: star, product_id: product_id)
  end
end

first = User.first
first.orders.create!(status: 2)

orders = Order.all
orders.each do |order|
  amount = 0
  rand(1..5).times do
    product_id = rand(1..40)
    quantity = rand(1..3)
    od = order.order_details.new(product_id: product_id, quantity: quantity)
    od.save!
    price = od.product.price
    od.update(price: price)
  end
  amount = 0
  order.order_details.each do |od|
    amount += od.price * od.quantity
  end
  order.update(amount: amount)
end
