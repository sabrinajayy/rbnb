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

  artist = Artist.create({ user: user, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, tags: my_tags.join(' '), location: "Milan" , category: categories.sample, photo: image, travel_range: 20 })
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
                         rating: 3
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
times = [DateTime.yesterday, DateTime.new(2017,9,10), DateTime.new(2017,9,25), DateTime.new(2017,9,17), DateTime.new(2017,10,1)]
times.each do |t|
  ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: t, status: 'confirmed')
end

"Creating a review for Sarah"
booking = ConsumerRequest.first
Review.create(title: 'She was great!',
              content: 'She did my makeup and she was great',
              rating: 5,
              consumer_request: booking,
              user: hero_user,
              artist: artist_sarah
              )


puts "Creating Consumer Events for Hero user"
times.each do |t|
  ConsumerEvent.create(location: 'Milan', service: 'makeup', description: 'my birthday', user: hero_user, date: t)
end

puts "Creating an Artist Request from Sarah to work Hero user's event"
event = ConsumerEvent.last
ArtistRequest.new(offer_price: 50.0, artist: artist_sarah, consumer_event: event)

puts
puts "Ensuring that Sarah will always be busy today in the morning"
booking = ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.change(hour: 11), status: 'confirmed')
TimeBlock.create(artist: artist_sarah, date: booking.date, consumer_request: booking)
puts
puts "Ensuring that Sarah will always be busy in two days in the afternoon."
booking = ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.advance(days: 2).change(hour: 15), status: 'confirmed')
TimeBlock.create(artist: artist_sarah, date: booking.date, consumer_request: booking)
puts
puts "Ensuring that Sarah will always be busy in three days in the evening."
booking = ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.advance(days: 3).change(hour: 22), status: 'confirmed')
TimeBlock.create(artist: artist_sarah, date: booking.date, consumer_request: booking)

puts "Creating a rival artist to bid against Sarah"
user = User.create(email: 'rival@rival.com', password: 'password')
artist_rival = Artist.create({ user: user,
                         first_name: 'Rival',
                         last_name: 'Artist',
                         tags: "#gothic #natural #lazysundaydays #afternoondelight",
                         photo: "https://i.pinimg.com/originals/0b/3c/f9/0b3cf9a6887049b4fe833810c286ae3e.jpg",
                         category: 'makeup',
                         location: 'Milan',
                         travel_range: 20,
                         rating: 4.7
                         })
puts
puts "Creating a new event, with two artist requests: one from Sarah and the other from a rival artist."
event = ConsumerEvent.create(location: 'Milan', service: 'makeup', description: 'my face day', user: hero_user, date: DateTime.now.advance(days: 1))
ArtistRequest.create(offer_price: 30.0, consumer_event: event, artist: artist_sarah, message: "Hi, I have ten years of experience doing the thing that you need.")
ArtistRequest.create(offer_price: 20.0, consumer_event: event, artist: artist_rival, message: "Hello there, I have no experience but I'm cheap.")
