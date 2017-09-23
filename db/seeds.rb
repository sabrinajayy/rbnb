require 'date'

ArtistService.destroy_all
ArtistRequest.destroy_all
Consumer.destroy_all
Review.destroy_all

ConsumerRequest.destroy_all
TimeBlock.destroy_all
ConsumerEvent.destroy_all
Artist.destroy_all
User.destroy_all

categories = ['hair', 'makeup', 'hair and makeup']
locations = ['Barcelona', 'New York', 'Paris']


real_images = ["https://i.pinimg.com/736x/40/32/e0/4032e0031e2e95989f1e76fe3d4f57b7--face-profile-women-profile-face.jpg",
               "https://i.pinimg.com/736x/f1/3e/57/f13e57e1e26e1ba8553cca156f28b23a--headshot-poses-headshot-photography.jpg",
               "http://steminist.com/wp-content/uploads/2015/07/IMG_0440.jpg",
               "http://corkbusiness.ie/wp-content/uploads/2014/08/2373034-laura-vanderkam-profile.jpg"]

tags = ["ecofriendly", "costume", "wedding", "birthday", "fierce", "natural", "whatever", "ilovejesus", "brash", "sass"]

puts
puts "Seeding Pamperd environment"
puts "Creating admin user"

User.create({email: 'admin@admin.com', password: 'password', admin: true})

real_images.each do |image|
  user = User.create({ email: Faker::Internet.email, password: Faker::Internet.password })
  my_tags = []

  rand(3...7).times do
    my_tags << tags.delete(tags.sample)
  end

  artist = Artist.create({ user: user, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, tags: my_tags.join(' '), location: "Milan" , category: categories.sample, photo: image, travel_range: 20, rating: 0.0 })
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
                         location: 'Carrer Pere Serafi, Barcelona',
                         bio: "Sarah has always had a passion for the arts. She started her professional career at MAC Cosmetics in 2003. Sarah is continually inspired by her clients and the creative collaborators she works alongside.",
                         travel_range: 20,
                         rating: 4.7
                         })

puts "Creating Sarah's Services"
ArtistService.create(name: 'Full Face Makeup',price: 50.0,artist: artist_sarah)
ArtistService.create(name: "Lashes",price: 30.0,artist: artist_sarah)
ArtistService.create(name: "Special FX",price: 75.0,artist: artist_sarah)
ArtistService.create(name: "Wedding Day Service",price: 250.0,artist: artist_sarah)
ArtistService.create(name: "Lesson", price: 50.0,artist: artist_sarah)
puts


puts "Creating and artist called Angelo"
user = User.create({ email: 'angelo@angelo.com', password: 'password' })
artist_angelo = Artist.create({ user: user,
                         first_name: 'Angelo',
                         last_name: 'Cervantes',
                         tags: "#onfleek #unnatural #busysaturdays #eveningdelight",
                         photo: "http://m1.22slides.com/jaleesajaikaran/4448_image_661127.jpg",
                         category: 'makeup',
                         location: "Carrer d'Aribau, 51, 08011 Barcelona",
                         bio: "Hey guys, I really love all things beauty.",
                         travel_range: 20,
                         rating: 4.7
                         })
puts "Creating Angelo's Services"
ArtistService.create(name: 'Full Face Makeup',price: 40.0,artist: artist_sarah)
ArtistService.create(name: "Lashes",price: 20.0,artist: artist_sarah)
ArtistService.create(name: "Special FX",price: 60.0,artist: artist_sarah)
ArtistService.create(name: "Wedding Day Service",price: 200.0,artist: artist_sarah)
ArtistService.create(name: "Lesson", price: 30.0,artist: artist_sarah)
puts
#
# seed hero user
hero_user = User.create(email: 'hero@hero.com', password: 'password')
Consumer.create(user: hero_user, first_name: 'Bruce', last_name: 'Wayne', city: 'Barcelona', phone_number: '500-500-500', instagram: '@secret_hero')

puts
puts "Creating Consumer Requests"
times = [DateTime.yesterday, DateTime.new(2017,9,10), DateTime.new(2017,9,25), DateTime.new(2017,9,17), DateTime.new(2017,10,1)]
times.each do |t|
  ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: t, status: 'confirmed')
end

puts "Creating reviews for Sarah"
['special', 'gracious', 'ugly', 'messy', 'stupid','giant'].each do |word|

  booking = ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.new(2017, 8, rand(12)+1), status: 'confirmed')

  Review.create(
                content: "She did my makeup and she was #{word}",
                rating: rand(5).to_f,
                consumer_request: booking,
                user: hero_user,
                artist: artist_sarah
                )
end


puts "Creating Consumer Events near Sarah"

event_locations = ["Carrer d'Astúries, 15, Barcelona",
                   "Carrer de Bonavista, Barcelona",
                   "14 Carrer de Casanova, Barcelona",
                   "Avinguda Diagonal, 247, Barcelona",
                   "Carrer de Provença, 238, Barcelona"]

event_descriptions = ["Birthday party.",
                      "Wedding rehearsal dinner.",
                      "Prom.",
                      "Graduation dinner.",
                      "Intimate gathering."]
puts "Creating events near to Sarah to show on her search"
event_dates = 5.times.map { |i| DateTime.new(2017, rand(2) + 9, rand(20) + 1, rand(10) + 9) }
event_users = 5.times.map { |i| User.create(email: Faker::Internet.email, password: Faker::Internet.password) }
event_users.each { |i| Consumer.create(user: i, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, city: 'Barcelona', phone_number: '500-500-500', instagram: '@secret_hero') }
event_users.each_with_index { |user, i| ConsumerEvent.create(location: event_locations[i], service: 'makeup', description: event_descriptions[i], user: user, date: event_dates[i], budget: rand(20) * 10) }

puts "Creating a new event, with two artist requests: one from Sarah and the other from a rival artist."
event = ConsumerEvent.create(location: 'Carrer de Ferran, 57, Barcelona', service: 'makeup', description: "Daughter's Birthday Party", budget: 50, user: hero_user, date: DateTime.now.advance(days: 1))


# puts "Creating an Artist Request from Sarah to work Hero user's event"
# ArtistRequest.create(offer_price: 50.0, artist: artist_sarah, consumer_event: event, message: "Hi, I have ten years of experience doing the thing that you need.")


puts "Creating an Artist Request from Angelo to work Hero user's event"
ArtistRequest.create(offer_price: 50.0, artist: artist_angelo, consumer_event: event, message: "Hello there, I have no experience but I'm cheap.")

puts
puts "Ensuring that Sarah will always be busy today in the morning"
booking = ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.change(hour: 11), status: 'confirmed')
TimeBlock.create(artist: artist_sarah, date: booking.date, consumer_request: booking, end_date: booking.date.advance(hours: 1))
puts
puts "Ensuring that Sarah will always be busy in two days in the afternoon."
booking = ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.advance(days: 2).change(hour: 15), status: 'confirmed')
TimeBlock.create(artist: artist_sarah, date: booking.date, consumer_request: booking, end_date: booking.date.advance(hours: 1))
puts
puts "Ensuring that Sarah will always be busy in three days in the evening."
booking = ConsumerRequest.create(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.advance(days: 3).change(hour: 22), status: 'confirmed')
TimeBlock.create(artist: artist_sarah, date: booking.date, consumer_request: booking, end_date: booking.date.advance(hours: 1))





