# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# puts
# puts "seeding 5 user consumers"
# puts "please wait"
# 5.times do
#   user = User.create({ email: Faker::Internet.email, password: Faker::Internet.password })
#   consumer = Consumer.create({ user: user, first_name: Faker::Name.name, last_name: Faker::Name.name, city: Faker::Address.city, phone_number: Faker::Number.number(8).to_i, instagram: '@' + Faker::App.name})
# end

require 'date'
categories = ['hair', 'makeup', 'hair and makeup']
locations = ['Barcelona', 'New York', 'Paris']


real_images = ["https://i.pinimg.com/736x/40/32/e0/4032e0031e2e95989f1e76fe3d4f57b7--face-profile-women-profile-face.jpg",
               "https://i.pinimg.com/736x/f1/3e/57/f13e57e1e26e1ba8553cca156f28b23a--headshot-poses-headshot-photography.jpg",
               "http://steminist.com/wp-content/uploads/2015/07/IMG_0440.jpg",
               "http://corkbusiness.ie/wp-content/uploads/2014/08/2373034-laura-vanderkam-profile.jpg"]

tags = ["ecofriendly", "costume", "wedding", "birthday", "fierce", "natural", "whatever", "ilovejesus", "brash", "sass"]

real_images.each do |image|
  user = User.create({ email: Faker::Internet.email, password: Faker::Internet.password })
  my_tags = []

  rand(3...7).times do
    my_tags << tags.delete(tags.sample)
  end

  artist = Artist.create({ user: user, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, tags: my_tags.join(' '), location: "Milan" , category: categories.sample, photo: image })
  5.times do
    ArtistService.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, artist: artist )
  end
end

puts "Creating and artist called Sarah"

user = User.create({ email: 'sarah@sarah.com', password: 'password' })
artist_sarah = Artist.create({ user: user,
                         first_name: 'Sarah',
                         last_name: 'Leibowitz',
                         tags: "#gothic #natural #lazysundaydays #afternoondelight",
                         photo: "http://www.vivianmakeupartist.com/wp-content/uploads/2017/01/vivianmakeupartist_boldlip.jpg",
                         category: 'makeup',
                         location: 'Milan',
                         travel_range: 20,
                         })

puts "Creating Sarah's Services"
ArtistService.create(name: 'Full Face Makeup',price: 50.0,artist: artist_sarah)
ArtistService.create(name: "Lashes",price: 30.0,artist: artist_sarah)
ArtistService.create(name: "Special FX",price: 75.0,artist: artist_sarah)
ArtistService.create(name: "Wedding Day Service",price: 250.0,artist: artist_sarah)
ArtistService.create(name: "Lesson", price: 50.0,artist: artist_sarah)
puts
puts "seeding 20 user artists"
puts "please wait"
20.times do
  user = User.create({ email: Faker::Internet.email, password: Faker::Internet.password })
  artist = Artist.create({ user: user, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, tags: 'tagtagtag', location: locations.sample , category: categories.sample, travel_range: 20 })
  5.times do
    ArtistService.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, artist: artist )
  end
end
# seed hero user
hero_user = User.create(email: 'hero@hero.com', password: 'password')
Consumer.create(user: hero_user, first_name: 'Bruce', last_name: 'Wayne', city: 'Milan', phone_number: '500-500-500', instagram: '@secret_hero')

puts
puts "Creating Consumer Requests"
times = [DateTime.new(2017,9,1), DateTime.new(2017,9,10), DateTime.new(2017,9,25), DateTime.new(2017,9,17), DateTime.new(2017,10,1)]
times.each do |t|
  ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: t, status: 'confirmed')
end

puts "Creating Consumer Events"
ConsumerEvent.create(location: 'Milan', service: 'makeup', description: 'my birthday', user: hero_user)


  # create_table "consumer_events", force: :cascade do |t|
  #   t.string   "location"
  #   t.datetime "date"
  #   t.string   "service"
  #   t.text     "description"
  #   t.string   "tags"
  #   t.float    "budget"
  #   t.integer  "user_id"
  #   t.datetime "created_at",  null: false
  #   t.datetime "updated_at",  null: false
  #   t.index ["user_id"], name: "index_consumer_events_on_user_id", using: :btree
  # end




