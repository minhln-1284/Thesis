require 'faker'

count = 1
20.times do
  user = User.new
  user.email = "user-#{count}@gmail.com"
  user.name = Faker::Name.first_name
  user.phone = Faker::PhoneNumber.cell_phone
  user.password = "foobar"
  user.password_confirmation = "foobar"
  user.save!
  count += 1
end

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
10.times do
  men = Category.find_by(id: 3)
  shirt_men = men.products.new
  shirt_men.price = 1000000
  shirt_men.quantity_in_stock = 500
  shirt_men.save!
  product_image_sm = shirt_men.product_images.create!
  product_image_sm.image.attach(io: File.open("app/assets/images/DatasetProductImages/Mens/Shirt/#{count}.jpg"), filename: "#{count}.jpg")

  woman = Category.find_by(id: 4)
  shirt_woman = woman.products.new
  shirt_woman.price = 1000000
  shirt_woman.quantity_in_stock = 500
  shirt_woman.save!
  product_image_sw = shirt_woman.product_images.create!
  product_image_sw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Shirt/#{count}.jpg"), filename: "#{count}.jpg")

  count += 1
end

count = 1
10.times do
  men = Category.find_by(id: 5)
  pants_men = men.products.new
  pants_men.name = "Pants-P#{count}"
  pants_men.price = 1000000
  pants_men.quantity_in_stock = 500
  pants_men.save!
  product_image_pm = pants_men.product_images.create!
  product_image_pm.image.attach(io: File.open("app/assets/images/DatasetProductImages/Mens/Pants/#{count}.jpg"), filename: "#{count}.jpg")

  woman = Category.find_by(id: 6)
  pants_woman = woman.products.new
  pants_woman.name = "Pants-P#{count}"
  pants_woman.price = 1000000
  pants_woman.quantity_in_stock = 500
  pants_woman.save!
  product_image_pw = pants_woman.product_images.create!
  product_image_pw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Pants/#{count}.jpg"), filename: "#{count}.jpg")

  count += 1
end

count = 1
10.times do
  men = Category.find_by(id: 7)
  shoes_men = men.products.new
  shoes_men.name = "Shoes-S#{count}"
  shoes_men.price = 1000000
  shoes_men.quantity_in_stock = 500
  shoes_men.save!
  product_image_pm = shoes_men.product_images.create!
  product_image_pm.image.attach(io: File.open("app/assets/images/DatasetProductImages/Mens/Shoes/#{count}.jpg"), filename: "#{count}.jpg")

  woman = Category.find_by(id: 8)
  shoes_woman = woman.products.new
  shoes_woman.name = "Shoes-S#{count}"
  shoes_woman.price = 1000000
  shoes_woman.quantity_in_stock = 500
  shoes_woman.save!
  product_image_pw = shoes_woman.product_images.create!
  product_image_pw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Shoes/#{count}.jpg"), filename: "#{count}.jpg")

  count += 1
end

count = 1
10.times do
  men = Category.find_by(id: 9)
  accessories_men = men.products.new
  accessories_men.name = "Accessories-A#{count}"
  accessories_men.price = 1000000
  accessories_men.quantity_in_stock = 500
  accessories_men.save!
  product_image_pm = accessories_men.product_images.create!
  product_image_pm.image.attach(io: File.open("app/assets/images/DatasetProductImages/Mens/Accessories/#{count}.jpg"), filename: "#{count}.jpg")

  woman = Category.find_by(id: 10)
  accessories_woman = woman.products.new
  accessories_woman.name = "Accessories-A#{count}"
  accessories_woman.price = 1000000
  accessories_woman.quantity_in_stock = 500
  accessories_woman.save!
  product_image_pw = accessories_woman.product_images.create!
  product_image_pw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Accessories/#{count}.jpg"), filename: "#{count}.jpg")

  count += 1
end

count = 1
10.times do
  woman = Category.find_by(id: 11)
  dress_woman = woman.products.new
  dress_woman.name = "Dress-D#{count}"
  dress_woman.price = 1000000
  dress_woman.quantity_in_stock = 500
  dress_woman.save!
  product_image_pw = dress_woman.product_images.create!
  product_image_pw.image.attach(io: File.open("app/assets/images/DatasetProductImages/Womans/Dresses & Skirts/#{count}.jpg"), filename: "#{count}.jpg")

  count += 1
end
