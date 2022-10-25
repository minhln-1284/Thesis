require 'faker'

count = 1
450.times do
  user = User.new
  user.email = "user-#{count}@gmail.com"
  user.name = Faker::Name.first_name
  user.phone = Faker::PhoneNumber.cell_phone
  user.password = "foobar"
  user.password_confirmation = "foobar"
  user.save!
  count += 1
end
User.create(email: "shinra241@gmail.com", password: "foobar",
            password_confirmation: "foobar", phone: Faker::PhoneNumber.cell_phone,
            name: Faker::Name.first_name, role: 0)

men = Category.create!(name: "Mens")
woman = Category.create!(name: "Womans")

men.categories.create!(name: "Shirt")
woman.categories.create!(name: "Shirt")

men.categories.create!(name: "Pants")
woman.categories.create!(name: "Pants")

men.categories.create!(name: "Shoes")
woman.categories.create!(name: "Shoes")

men.categories.create!(name: "Accessories")
woman.categories.create!(name: "Accessories")

woman.categories.create!(name: "Dresses & Skirts")

count = 1
35.times do
  men = Category.find_by(id: 3)
  shirt_men = men.products.new
  shirt_men.name = "Shirt-SM#{count}"
  shirt_men.price = rand(1000000..5000000)
  shirt_men.quantity_in_stock = 500
  shirt_men.description = Faker::Lorem.paragraph(sentence_count: 3)
  shirt_men.save!
  product_image_sm = shirt_men.product_images.create!
  product_image_sm.image.attach(io: File.open("app/assets/images/DatasetProductImages/Mens/Shirt/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")

  woman = Category.find_by(id: 4)
  shirt_woman = woman.products.new
  shirt_woman.name = "Shirt-SW#{count}"
  shirt_woman.price = rand(1000000..5000000)
  shirt_woman.quantity_in_stock = 500
  shirt_woman.description = Faker::Lorem.paragraph(sentence_count: 3)
  shirt_woman.save!
  product_image_sw = shirt_woman.product_images.create!
  product_image_sw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Shirt/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")

  count += 1
end

count = 1
35.times do
  men = Category.find_by(id: 5)
  pants_men = men.products.new
  pants_men.name = "Pants-P#{count}"
  pants_men.price = rand(1000000..5000000)
  pants_men.quantity_in_stock = 500
  pants_men.description = Faker::Lorem.paragraph(sentence_count: 3)
  pants_men.save!
  product_image_pm = pants_men.product_images.create!
  product_image_pm.image.attach(io: File.open("app/assets/images/DatasetProductImages/Mens/Pants/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")

  woman = Category.find_by(id: 6)
  pants_woman = woman.products.new
  pants_woman.name = "Pants-P#{count}"
  pants_woman.price = rand(1000000..5000000)
  pants_woman.quantity_in_stock = 500
  pants_woman.description = Faker::Lorem.paragraph(sentence_count: 3)
  pants_woman.save!
  product_image_pw = pants_woman.product_images.create!
  product_image_pw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Pants/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")
  count += 1
end

count = 1
35.times do
  men = Category.find_by(id: 7)
  shoes_men = men.products.new
  shoes_men.name = "Shoes-S#{count}"
  shoes_men.price = rand(1000000..5000000)
  shoes_men.quantity_in_stock = 500
  shoes_men.description = Faker::Lorem.paragraph(sentence_count: 3)
  shoes_men.save!
  product_image_pm = shoes_men.product_images.create!
  product_image_pm.image.attach(io: File.open("app/assets/images/DatasetProductImages/Mens/Shoes/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")

  woman = Category.find_by(id: 8)
  shoes_woman = woman.products.new
  shoes_woman.name = "Shoes-S#{count}"
  shoes_woman.price = rand(1000000..5000000)
  shoes_woman.quantity_in_stock = 500
  shoes_woman.description = Faker::Lorem.paragraph(sentence_count: 3)
  shoes_woman.save!
  product_image_pw = shoes_woman.product_images.create!
  product_image_pw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Shoes/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")

  count += 1
end

count = 1
35.times do
  men = Category.find_by(id: 9)
  accessories_men = men.products.new
  accessories_men.name = "Accessories-A#{count}"
  accessories_men.price = rand(1000000..5000000)
  accessories_men.quantity_in_stock = 500
  accessories_men.description = Faker::Lorem.paragraph(sentence_count: 3)
  accessories_men.save!
  product_image_pm = accessories_men.product_images.create!
  product_image_pm.image.attach(io: File.open("app/assets/images/DatasetProductImages/Mens/Accessories/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")

  woman = Category.find_by(id: 10)
  accessories_woman = woman.products.new
  accessories_woman.name = "Accessories-A#{count}"
  accessories_woman.price = rand(1000000..5000000)
  accessories_woman.quantity_in_stock = 500
  accessories_woman.description = Faker::Lorem.paragraph(sentence_count: 3)
  accessories_woman.save!
  product_image_pw = accessories_woman.product_images.create!
  product_image_pw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Accessories/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")

  count += 1
end

count = 1
35.times do
  woman = Category.find_by(id: 11)
  dress_woman = woman.products.new
  dress_woman.name = "Dress-D#{count}"
  dress_woman.price = rand(1000000..5000000)
  dress_woman.quantity_in_stock = 500
  dress_woman.description = Faker::Lorem.paragraph(sentence_count: 3)
  dress_woman.save!
  product_image_pw = dress_woman.product_images.create!
  product_image_pw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Dresses & Skirts/#{rand(1..10)}.jpg"), filename: "#{rand(1..10)}.jpg")

  count += 1
end

users = User.all

users.each do |user|
  rand(3..30).times do
    status = rand(0..4)
    user.orders.create!(status: status)
  end
end

orders = Order.all
orders.each do |order|
  arr = (1..130).to_a
  rand(2..6).times do
    product_id = arr.sample
    quantity = rand(1..3)
    od = order.order_details.new(product_id: product_id, quantity: quantity)
    od.save!
    price = od.product.price
    od.update(price: price)
    arr.delete(product_id)
    star = rand(1..5)
    comment = Faker::Lorem.paragraph(sentence_count: 1)
    Rating.create!(product_id: product_id, user_id: order.user_id, star: star, comment: comment)
  end
  amount = 0
  order.order_details.each do |od|
    amount += od.price * od.quantity
  end
  order.update(amount: amount)
end
