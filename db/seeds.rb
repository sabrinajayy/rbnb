require 'date'

Message.destroy_all
ArtistImage.destroy_all
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


real_images = ["http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506332944/mua-girl_afps2u.jpg",
               "http://res.cloudinary.com/dl12g2ws3/image/upload/v1506332945/mua-angelo_mti7zn.jpg",
               "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506332945/mua-woman_l8tncl.jpg",
               "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506332946/mua-sarah_eexokm.jpg"]

real_names = ["Liz", "Michel", "Michela", "Jen", "Sally"]
real_services = ["Full Face Makeup", "Lashes", "Special FX", "Wedding Day Service", "Lesson"]

tags = ["#ecofriendly", "#costume", "#wedding", "#birthday", "#fierce", "#natural", "#whatever", "#ilovejesus", "#brash", "#sass"]

puts
puts "Seeding updo environment".upcase
puts "Creating admin user"

User.create!({email: 'admin@admin.com', password: 'password', admin: true})

puts "Creating 5 Artists in Barcelona"

real_names.each_with_index do |name, i|
  user = User.create!({ email: Faker::Internet.email, password: Faker::Internet.password })
  my_tags = []

  rand(3...7).times do
    my_tags << tags.delete(tags.sample)
  end

  artist = Artist.create!({ user: user, first_name: name, last_name: Faker::Name.last_name, tags: my_tags.join(' '), location: "Barcelona" , category: "makeup", photo: real_images[i], travel_range: 20, rating: rand(5).to_f })
  real_services.each do |service|
    ArtistService.create!(name: service, price: (rand(10) + 40).to_f, artist: artist )
  end
end
puts "Creating an artist called Sarah"

user = User.create!({ email: 'sarah@sarah.com', password: 'password' })
artist_sarah = Artist.create!({ user: user,
                         first_name: 'Sarah',
                         last_name: 'Leibowitz',
                         tags: "#haloween #gothic #natural #lazysundaydays #afternoondelight",
                         photo: "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333074/mua-real-sarah_ze70qf.jpg",
                         category: 'makeup',
                         location: 'Carrer Pere Serafi, Barcelona',
                         bio: "Sarah has always had a passion for the arts. She started her professional career at MAC Cosmetics in 2003. Sarah is continually inspired by her clients and the creative collaborators she works alongside.",
                         travel_range: 20,
                         rating: 4.7
                         })

puts "Creating Sarah's Services"
ArtistService.create!(name: 'Full Face Makeup',price: 50.0,artist: artist_sarah)
ArtistService.create!(name: "Lashes",price: 30.0,artist: artist_sarah)
ArtistService.create!(name: "Special FX",price: 75.0,artist: artist_sarah)
ArtistService.create!(name: "Wedding Day Service",price: 250.0,artist: artist_sarah)
ArtistService.create!(name: "Lesson", price: 50.0,artist: artist_sarah)
puts

sarah_artist_images = ["http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333831/good" + "%20" + "makeup/costume_makeup1.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333831/good%20makeup/costume_makeup2.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333831/good%20makeup/costume_makeup3.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333831/good%20makeup/costume_makeup4.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333831/good%20makeup/costume_makeup5.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333831/good%20makeup/costume_makeup6.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333831/good%20makeup/costume_makeup7.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333831/good%20makeup/costume_makeup8.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506333832/good%20makeup/costume_makeup9.jpg"]
sarah_artist_images.each { |i| ArtistImage.create!(artist: artist_sarah, image: i) }


puts "Creating and artist called Angelo"
user = User.create!({ email: 'angelo@angelo.com', password: 'password' })
artist_angelo = Artist.create!({ user: user,
                         first_name: 'Angelo',
                         last_name: 'Cervantes',
                         tags: "#onfleek #unnatural #busysaturdays #eveningdelight",
                         photo: "http://m1.22slides.com/jaleesajaikaran/4448_image_661127.jpg",
                         category: 'makeup',
                         location: "Carrer d'Aribau, 51, 08011 Barcelona",
                         bio: "Hey guys, I really love all things beauty.",
                         travel_range: 20,
                         rating: 0.0
                         })

puts "Creating Angelo's Services"
ArtistService.create!(name: 'Full Face Makeup',price: 40.0,artist: artist_sarah)
ArtistService.create!(name: "Lashes",price: 20.0,artist: artist_sarah)
ArtistService.create!(name: "Special FX",price: 60.0,artist: artist_sarah)
ArtistService.create!(name: "Wedding Day Service",price: 200.0,artist: artist_sarah)
ArtistService.create!(name: "Lesson", price: 30.0,artist: artist_sarah)
puts


angelo_artist_images = ["http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,w_1080/v1506334008/bad%20makeup/bad_makeup1.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506334008/bad%20makeup/bad_makeup2.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506334008/bad%20makeup/bad_makeup3.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506334008/bad%20makeup/bad_makeup4.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506334008/bad%20makeup/bad_makeup5.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506334008/bad%20makeup/bad_makeup6.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506334009/bad%20makeup/bad_makeup7.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506334008/bad%20makeup/bad_makeup8.jpg",
                       "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_1080,w_1080/v1506334009/bad%20makeup/bad_makeup9.jpg"]
angelo_artist_images.each { |i| ArtistImage.create!(artist: artist_angelo, image: i) }


#
# seed hero user
hero_user = User.create!(email: 'hero@hero.com', password: 'password')
Consumer.create!(user: hero_user, first_name: 'Bruce', last_name: 'Wayne', city: 'Barcelona', phone_number: '500-500-500', instagram: '@secret_hero')

puts
puts "Creating Consumer Requests"
times = [DateTime.yesterday, DateTime.new(2017,9,10), DateTime.new(2017,9,25), DateTime.new(2017,9,17), DateTime.new(2017,10,1)]
times.each do |t|
  ConsumerRequest.create!(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: t, status: 'confirmed')
end

sarah_consumer_images = ['http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506334654/review%20pics/profile_pic1B.jpg',
                         "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506334655/review%20pics/profile_pic1G.jpg",
                         "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506334654/review%20pics/profile_pic2G.jpg",
                         "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506334654/review%20pics/profile_pic3G.jpg",
                         "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506334654/review%20pics/profile_pic4G.jpg"]

angelo_consumer_images = ["http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506334654/review%20pics/profile_pic5G.jpg",
                          "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506334654/review%20pics/profile_pic6G.jpg",
                          "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506334195/review%20pics/stephanie.jpg",
                          "http://res.cloudinary.com/dl12g2ws3/image/upload/c_crop,h_300,w_300/v1506335246/review%20pics/beautiful-face-51.jpg"]


puts "Creating reviews for Sarah"
good_adjectives = ['great, and great value for money, the products she uses are all really great quality', 'so nice', 'really quick and friendly, I could not recommend her more', 'great with my kids and really attentive', 'so, so lovely']
mediocre_adjectives = ['ok', 'a little late and was kinda messy', 'kind of messy', "a bit rude and spent most of the time making phone calls, way, way too much drama"]

sarah_reviewers = ['Holly', 'Jenny', 'Will', 'Maria', 'Carmen']
angelo_reviewers = ['Margot', 'Sandra', 'Amelia', 'Silvia']

sarah_reviewers.each_with_index do |reviewer_name, i|
  user = User.create!({ email: Faker::Internet.email, password: Faker::Internet.password })
  consumer = Consumer.create!(user: user, first_name: reviewer_name, last_name: Faker::Name.last_name, profile_img: sarah_consumer_images[i], city: 'Barcelona', phone_number: Faker::PhoneNumber.cell_phone, instagram: reviewer_name)
  consumer_request = ConsumerRequest.create!(artist: artist_sarah, user_id: user.id, final_price: 50.0, servicename: real_services.sample, address: 'Barcelona', date: DateTime.now.advance(months: -(rand(2) + 1)), status: 'confirmed')
  Review.create!(
                content: "#{["Sarah", "She"].sample} #{['did my', 'sorted out my'].sample} #{consumer_request.servicename} and she was #{good_adjectives[i]}#{['.','!'].sample}",
                rating: (rand(2) + 4).to_f,
                consumer_request: consumer_request,
                user: user,
                artist: artist_sarah
                )
end

angelo_reviewers.each_with_index do |reviewer_name, i|
  user = User.create!({ email: Faker::Internet.email, password: Faker::Internet.password })
  consumer = Consumer.create!(user: user, first_name: reviewer_name, last_name: Faker::Name.last_name, profile_img: angelo_consumer_images[i], city: 'Barcelona', phone_number: Faker::PhoneNumber.cell_phone, instagram: reviewer_name)
  consumer_request = ConsumerRequest.create!(artist: artist_angelo, user_id: user.id, final_price: 50.0, servicename: real_services.sample, address: 'Barcelona', date: DateTime.now.advance(months: -(rand(2) + 1)), status: 'confirmed')
  Review.create!(
                content: "#{["Angelo", "He"].sample} did my #{consumer_request.servicename} and he was #{mediocre_adjectives[i]}#{['.','!'].sample}",
                rating: (rand(2) + 2).to_f,
                consumer_request: consumer_request,
                user: user,
                artist: artist_angelo
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
event_users = 5.times.map { |i| User.create!(email: Faker::Internet.email, password: Faker::Internet.password) }
event_users.each { |i| Consumer.create!(user: i, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, city: 'Barcelona', phone_number: '500-500-500', instagram: '@secret_hero') }
event_users.each_with_index { |user, i| ConsumerEvent.create!(location: event_locations[i], service: 'makeup', description: event_descriptions[i], user: user, date: event_dates[i], budget: ((rand(20) + 4) * 10).to_f) }

puts "Creating a new event, with two artist requests: one from Sarah and the other from a rival artist."
event = ConsumerEvent.create!(location: 'Carrer de Ferran, 57, Barcelona', service: 'makeup', description: "Daughter's Birthday Party", budget: 50, user: hero_user, date: DateTime.now.advance(days: 1))


puts "Creating an Artist Request from Angelo to work Hero user's event"
ArtistRequest.create!(offer_price: 50.0, artist: artist_angelo, consumer_event: event, message: "Hello there, I have no experience but I'm cheap.")

puts
puts "Ensuring that Sarah will always be busy today in the morning"
booking = ConsumerRequest.create!(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.change(hour: 11), status: 'confirmed')
TimeBlock.create!(artist: artist_sarah, date: booking.date, consumer_request: booking, end_date: booking.date.advance(hours: 1))
puts
puts "Ensuring that Sarah will always be busy in two days in the afternoon."
booking = ConsumerRequest.create!(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.advance(days: 2).change(hour: 15), status: 'confirmed')
TimeBlock.create!(artist: artist_sarah, date: booking.date, consumer_request: booking, end_date: booking.date.advance(hours: 1))
puts
puts "Ensuring that Sarah will always be busy in three days in the evening."
booking = ConsumerRequest.create!(artist: artist_sarah, user_id: hero_user.id, final_price: 50.0, servicename: 'Full Face Makeup', address: 'New York City', date: DateTime.now.advance(days: 3).change(hour: 22), status: 'confirmed')
TimeBlock.create!(artist: artist_sarah, date: booking.date, consumer_request: booking, end_date: booking.date.advance(hours: 1))

