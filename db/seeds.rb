require 'faker'

men = Category.create!(name: "Men")
woman = Category.create!(name: "Woman")
3.times do
  name = Faker::Music.genre
  cate1 = men.categories.new(name: name)
  cate1.save!
end

3.times do
  name = Faker::Emotion.noun
  cate1 = woman.categories.new(name: name)
  cate1.save!
end
