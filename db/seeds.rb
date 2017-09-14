# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = ['hair', 'makeup', 'hair and makeup']
locations = ['Barcelona', 'New York', 'Paris']

puts "seeding 20 user artists"
puts "please wait"
20.times do
  user = User.create({ email: Faker::Internet.email, password: Faker::Internet.password })
  artist = Artist.create({ user: user, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, tags: 'tagtagtag', location: locations.sample , category: categories.sample })
  5.times do
    ArtistService.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, artist: Artist.all.sample )
  end
end
puts
puts "seeding 5 user consumers"
puts "please wait"
5.times do
  user = User.create({ email: Faker::Internet.email, password: Faker::Internet.password })
  consumer = Consumer.create({ user: user, name: Faker::Name.name, city: Faker::Address.city, phone_number: Faker::Number.number(8).to_i, instagram: '@' + Faker::App.name})
end
