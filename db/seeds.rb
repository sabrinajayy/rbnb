# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = ['hair', 'makeup', 'both']
locations = ['Barcelona', 'New York', 'Paris']
puts "seeding 100 user artists"
puts "please wait"
100.times do
  user = User.create({ email: Faker::Internet.email, password: Faker::Internet.password })
  artist = Artist.create({ user: user, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, tags: 'tagtagtag', location: locations.sample , category: categories.sample })
end
puts "seeding 100 user consumers"
puts "please wait"
100.times do
  user = User.create({ email: Faker::Internet.email, password: Faker::Internet.password })
  consumer = Consumer.create({ user: user, name: Faker::Name.name, city: Faker::Address.city, phone_number: Faker::Number.number(8).to_i, instagram: '@' + Faker::App.name})
end
