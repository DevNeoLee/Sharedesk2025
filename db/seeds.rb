# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 50.times do |i|
#     Room.create(listing_name: 'Good morning room #{i}', user_id: 2)
# end

User.create(email: "justin@email.com", name: "justin", password: "111111")
User.create(email: "demo@email.com", name: "Demo User", password: "111111")

# Create sample rooms for different cities
user1 = User.find_by(email: "justin@email.com")
user2 = User.find_by(email: "demo@email.com")

# Helper method to create room with default image
def create_room_with_image(attributes)
  room = Room.new(attributes)
  # Attach a default image
  room.images.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.jpg')),
    filename: 'default_room.jpg',
    content_type: 'image/jpeg'
  )
  room.save!
  room
rescue => e
  puts "Error creating room: #{e.message}"
  # Create room without image if attachment fails
  room = Room.new(attributes)
  room.save!
  room
end

# NYC Rooms
create_room_with_image(
  user: user1,
  listing_name: "Manhattan Cozy Office",
  address: "New York, NYC, USA",
  summary: "Perfect workspace in the heart of Manhattan",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 2,
  noise_level: "Quiet",
  bath_room: 1,
  manager_on: "Fulltime",
  security_level: "High",
  price: 50,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: false,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 40.7128,
  longitude: -74.0060
)

create_room_with_image(
  user: user2,
  listing_name: "Brooklyn Creative Space",
  address: "Brooklyn, NYC, USA",
  summary: "Creative workspace in trendy Brooklyn",
  space_type: "Apartment",
  desk_type: "Sharing Table",
  capacity: 4,
  noise_level: "Casual",
  bath_room: 2,
  manager_on: "Parttime",
  security_level: "Good",
  price: 35,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: true,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 40.6782,
  longitude: -73.9442
)

# Kolkata Rooms
create_room_with_image(
  user: user1,
  listing_name: "Kolkata Business Center",
  address: "Kolkata, West Bengal, India",
  summary: "Professional workspace in Kolkata business district",
  space_type: "Office",
  desk_type: "Private Room Office",
  capacity: 3,
  noise_level: "Silent Mode",
  bath_room: 2,
  manager_on: "Fulltime",
  security_level: "Maximum",
  price: 25,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: false,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 22.5726,
  longitude: 88.3639
)

create_room_with_image(
  user: user2,
  listing_name: "Kolkata Home Office",
  address: "Kolkata, India",
  summary: "Comfortable home office space",
  space_type: "House",
  desk_type: "Single Desk",
  capacity: 1,
  noise_level: "Quiet",
  bath_room: 1,
  manager_on: "No Stay",
  security_level: "Good",
  price: 15,
  is_wifi: true,
  is_kitchen: false,
  is_air: true,
  is_heating: false,
  is_conference: false,
  is_drinks: false,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 22.5726,
  longitude: 88.3639
)

# Bangkok Rooms
create_room_with_image(
  user: user1,
  listing_name: "Bangkok Digital Nomad Hub",
  address: "Bangkok, Thailand",
  summary: "Perfect for digital nomads in Bangkok",
  space_type: "Apartment",
  desk_type: "Sharing Table",
  capacity: 6,
  noise_level: "Casual",
  bath_room: 2,
  manager_on: "Parttime",
  security_level: "High",
  price: 30,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: false,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 13.7563,
  longitude: 100.5018
)

create_room_with_image(
  user: user2,
  listing_name: "Bangkok Quiet Workspace",
  address: "Bangkok, Thailand",
  summary: "Peaceful workspace away from the city center",
  space_type: "House",
  desk_type: "Single Desk",
  capacity: 2,
  noise_level: "Silent Mode",
  bath_room: 1,
  manager_on: "No Stay",
  security_level: "Good",
  price: 20,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: false,
  is_conference: false,
  is_drinks: false,
  is_parking: true,
  is_printing: false,
  active: true,
  latitude: 13.7563,
  longitude: 100.5018
)

# Seattle Rooms
create_room_with_image(
  user: user1,
  listing_name: "Seattle Tech Hub",
  address: "Seattle, WA, USA",
  summary: "Modern workspace in the heart of Seattle's tech district",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 8,
  noise_level: "Quiet",
  bath_room: 3,
  manager_on: "Fulltime",
  security_level: "High",
  price: 45,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 47.6062,
  longitude: -122.3321
)

create_room_with_image(
  user: user2,
  listing_name: "Seattle Coffee Workspace",
  address: "Seattle, WA, USA",
  summary: "Cozy workspace with great coffee and city views",
  space_type: "Cafe",
  desk_type: "Sharing Table",
  capacity: 4,
  noise_level: "Casual",
  bath_room: 1,
  manager_on: "Parttime",
  security_level: "Good",
  price: 25,
  is_wifi: true,
  is_kitchen: false,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: true,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 47.6062,
  longitude: -122.3321
)

create_room_with_image(
  user: user1,
  listing_name: "Seattle Waterfront Office",
  address: "Seattle, WA, USA",
  summary: "Premium workspace with stunning waterfront views",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 6,
  noise_level: "Quiet",
  bath_room: 2,
  manager_on: "Fulltime",
  security_level: "High",
  price: 60,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 47.6062,
  longitude: -122.3321
)

create_room_with_image(
  user: user2,
  listing_name: "Seattle University District",
  address: "Seattle, WA, USA",
  summary: "Student-friendly workspace near University of Washington",
  space_type: "Apartment",
  desk_type: "Sharing Table",
  capacity: 5,
  noise_level: "Casual",
  bath_room: 1,
  manager_on: "Parttime",
  security_level: "Good",
  price: 20,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: false,
  is_parking: true,
  is_printing: false,
  active: true,
  latitude: 47.6062,
  longitude: -122.3321
)

create_room_with_image(
  user: user1,
  listing_name: "Seattle Capitol Hill Creative",
  address: "Seattle, WA, USA",
  summary: "Creative workspace in vibrant Capitol Hill neighborhood",
  space_type: "Studio",
  desk_type: "Sharing Table",
  capacity: 4,
  noise_level: "Casual",
  bath_room: 1,
  manager_on: "No Stay",
  security_level: "Good",
  price: 30,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: true,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 47.6062,
  longitude: -122.3321
)

# Tokyo Rooms
create_room_with_image(
  user: user1,
  listing_name: "Tokyo Shibuya Tech Space",
  address: "Tokyo, Japan",
  summary: "Modern tech workspace in the heart of Shibuya",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 10,
  noise_level: "Quiet",
  bath_room: 3,
  manager_on: "Fulltime",
  security_level: "High",
  price: 50,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 35.6762,
  longitude: 139.6503
)

create_room_with_image(
  user: user2,
  listing_name: "Tokyo Ginza Business Center",
  address: "Tokyo, Japan",
  summary: "Premium business workspace in prestigious Ginza district",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 8,
  noise_level: "Silent Mode",
  bath_room: 4,
  manager_on: "Fulltime",
  security_level: "High",
  price: 70,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 35.6762,
  longitude: 139.6503
)

create_room_with_image(
  user: user1,
  listing_name: "Tokyo Harajuku Creative Hub",
  address: "Tokyo, Japan",
  summary: "Creative workspace in trendy Harajuku area",
  space_type: "Studio",
  desk_type: "Sharing Table",
  capacity: 6,
  noise_level: "Casual",
  bath_room: 2,
  manager_on: "Parttime",
  security_level: "Good",
  price: 35,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: true,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 35.6762,
  longitude: 139.6503
)

create_room_with_image(
  user: user2,
  listing_name: "Tokyo Akihabara Gaming Space",
  address: "Tokyo, Japan",
  summary: "Gaming and tech workspace in Akihabara electronics district",
  space_type: "Apartment",
  desk_type: "Single Desk",
  capacity: 4,
  noise_level: "Casual",
  bath_room: 1,
  manager_on: "Parttime",
  security_level: "Good",
  price: 25,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: true,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 35.6762,
  longitude: 139.6503
)

create_room_with_image(
  user: user1,
  listing_name: "Tokyo Roppongi Hills Office",
  address: "Tokyo, Japan",
  summary: "Luxury workspace with city skyline views in Roppongi Hills",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 6,
  noise_level: "Quiet",
  bath_room: 2,
  manager_on: "Fulltime",
  security_level: "High",
  price: 80,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 35.6762,
  longitude: 139.6503
)

# Vancouver Rooms
create_room_with_image(
  user: user1,
  listing_name: "Vancouver Downtown Tech Hub",
  address: "Vancouver, BC, Canada",
  summary: "Modern tech workspace in downtown Vancouver",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 8,
  noise_level: "Quiet",
  bath_room: 3,
  manager_on: "Fulltime",
  security_level: "High",
  price: 45,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 49.2827,
  longitude: -123.1207
)

create_room_with_image(
  user: user2,
  listing_name: "Vancouver Gastown Creative",
  address: "Vancouver, BC, Canada",
  summary: "Creative workspace in historic Gastown district",
  space_type: "Studio",
  desk_type: "Sharing Table",
  capacity: 5,
  noise_level: "Casual",
  bath_room: 2,
  manager_on: "Parttime",
  security_level: "Good",
  price: 30,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: true,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 49.2827,
  longitude: -123.1207
)

create_room_with_image(
  user: user1,
  listing_name: "Vancouver West End Cozy",
  address: "Vancouver, BC, Canada",
  summary: "Cozy workspace in residential West End neighborhood",
  space_type: "Apartment",
  desk_type: "Single Desk",
  capacity: 3,
  noise_level: "Silent Mode",
  bath_room: 1,
  manager_on: "No Stay",
  security_level: "Good",
  price: 25,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: false,
  is_parking: true,
  is_printing: false,
  active: true,
  latitude: 49.2827,
  longitude: -123.1207
)

create_room_with_image(
  user: user2,
  listing_name: "Vancouver Yaletown Business",
  address: "Vancouver, BC, Canada",
  summary: "Professional business workspace in trendy Yaletown",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 6,
  noise_level: "Quiet",
  bath_room: 2,
  manager_on: "Fulltime",
  security_level: "High",
  price: 50,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 49.2827,
  longitude: -123.1207
)

create_room_with_image(
  user: user1,
  listing_name: "Vancouver Kitsilano Beach Workspace",
  address: "Vancouver, BC, Canada",
  summary: "Relaxed workspace near Kitsilano Beach with ocean views",
  space_type: "House",
  desk_type: "Sharing Table",
  capacity: 4,
  noise_level: "Casual",
  bath_room: 1,
  manager_on: "Parttime",
  security_level: "Good",
  price: 35,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: true,
  is_parking: true,
  is_printing: false,
  active: true,
  latitude: 49.2827,
  longitude: -123.1207
)

# Los Angeles Rooms
create_room_with_image(
  user: user1,
  listing_name: "LA Hollywood Creative Studio",
  address: "Los Angeles, CA, USA",
  summary: "Creative workspace in the heart of Hollywood",
  space_type: "Studio",
  desk_type: "Sharing Table",
  capacity: 6,
  noise_level: "Casual",
  bath_room: 2,
  manager_on: "Parttime",
  security_level: "Good",
  price: 40,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: false,
  is_conference: false,
  is_drinks: true,
  is_parking: true,
  is_printing: false,
  active: true,
  latitude: 34.0522,
  longitude: -118.2437
)

create_room_with_image(
  user: user2,
  listing_name: "LA Santa Monica Tech Hub",
  address: "Los Angeles, CA, USA",
  summary: "Modern tech workspace near the beach in Santa Monica",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 8,
  noise_level: "Quiet",
  bath_room: 3,
  manager_on: "Fulltime",
  security_level: "High",
  price: 55,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: false,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 34.0522,
  longitude: -118.2437
)

create_room_with_image(
  user: user1,
  listing_name: "LA Downtown Business Center",
  address: "Los Angeles, CA, USA",
  summary: "Professional business workspace in downtown LA",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 10,
  noise_level: "Quiet",
  bath_room: 4,
  manager_on: "Fulltime",
  security_level: "High",
  price: 65,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: false,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 34.0522,
  longitude: -118.2437
)

create_room_with_image(
  user: user2,
  listing_name: "LA Venice Beach Cozy",
  address: "Los Angeles, CA, USA",
  summary: "Cozy workspace in trendy Venice Beach neighborhood",
  space_type: "Apartment",
  desk_type: "Sharing Table",
  capacity: 4,
  noise_level: "Casual",
  bath_room: 1,
  manager_on: "No Stay",
  security_level: "Good",
  price: 30,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: false,
  is_conference: false,
  is_drinks: false,
  is_parking: true,
  is_printing: false,
  active: true,
  latitude: 34.0522,
  longitude: -118.2437
)

create_room_with_image(
  user: user1,
  listing_name: "LA Beverly Hills Luxury",
  address: "Los Angeles, CA, USA",
  summary: "Luxury workspace in prestigious Beverly Hills",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 6,
  noise_level: "Silent Mode",
  bath_room: 3,
  manager_on: "Fulltime",
  security_level: "High",
  price: 90,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: false,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 34.0522,
  longitude: -118.2437
)

# Toronto Rooms
create_room_with_image(
  user: user1,
  listing_name: "Toronto Downtown Tech Space",
  address: "Toronto, ON, Canada",
  summary: "Modern tech workspace in downtown Toronto",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 8,
  noise_level: "Quiet",
  bath_room: 3,
  manager_on: "Fulltime",
  security_level: "High",
  price: 50,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 43.6532,
  longitude: -79.3832
)

create_room_with_image(
  user: user2,
  listing_name: "Toronto Queen West Creative",
  address: "Toronto, ON, Canada",
  summary: "Creative workspace in trendy Queen West neighborhood",
  space_type: "Studio",
  desk_type: "Sharing Table",
  capacity: 5,
  noise_level: "Casual",
  bath_room: 2,
  manager_on: "Parttime",
  security_level: "Good",
  price: 35,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: true,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 43.6532,
  longitude: -79.3832
)

create_room_with_image(
  user: user1,
  listing_name: "Toronto Financial District",
  address: "Toronto, ON, Canada",
  summary: "Professional workspace in Toronto's financial district",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 6,
  noise_level: "Silent Mode",
  bath_room: 2,
  manager_on: "Fulltime",
  security_level: "High",
  price: 60,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 43.6532,
  longitude: -79.3832
)

create_room_with_image(
  user: user2,
  listing_name: "Toronto Kensington Market",
  address: "Toronto, ON, Canada",
  summary: "Unique workspace in eclectic Kensington Market area",
  space_type: "Apartment",
  desk_type: "Sharing Table",
  capacity: 3,
  noise_level: "Casual",
  bath_room: 1,
  manager_on: "No Stay",
  security_level: "Good",
  price: 25,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: false,
  is_drinks: false,
  is_parking: false,
  is_printing: false,
  active: true,
  latitude: 43.6532,
  longitude: -79.3832
)

create_room_with_image(
  user: user1,
  listing_name: "Toronto Harbourfront Office",
  address: "Toronto, ON, Canada",
  summary: "Premium workspace with lake views at Harbourfront",
  space_type: "Office",
  desk_type: "Single Desk",
  capacity: 4,
  noise_level: "Quiet",
  bath_room: 2,
  manager_on: "Fulltime",
  security_level: "High",
  price: 55,
  is_wifi: true,
  is_kitchen: true,
  is_air: true,
  is_heating: true,
  is_conference: true,
  is_drinks: true,
  is_parking: true,
  is_printing: true,
  active: true,
  latitude: 43.6532,
  longitude: -79.3832
)

# Create additional users for reviews
User.create(email: "sarah@email.com", name: "Sarah Johnson", password: "111111")
User.create(email: "mike@email.com", name: "Mike Chen", password: "111111")
User.create(email: "emma@email.com", name: "Emma Wilson", password: "111111")
User.create(email: "david@email.com", name: "David Brown", password: "111111")
User.create(email: "lisa@email.com", name: "Lisa Garcia", password: "111111")
User.create(email: "james@email.com", name: "James Taylor", password: "111111")
User.create(email: "anna@email.com", name: "Anna Rodriguez", password: "111111")
User.create(email: "robert@email.com", name: "Robert Lee", password: "111111")
User.create(email: "yuki@email.com", name: "Yuki Tanaka", password: "111111")
User.create(email: "min@email.com", name: "Min Park", password: "111111")
User.create(email: "hans@email.com", name: "Hans Mueller", password: "111111")
User.create(email: "sophie@email.com", name: "Sophie Martin", password: "111111")
User.create(email: "pierre@email.com", name: "Pierre Dubois", password: "111111")
User.create(email: "alex@email.com", name: "Alex Thompson", password: "111111")

# Get all users and rooms for reviews
users = User.all
rooms = Room.all

# Create sample reviews
reviews_data = [
  # NYC Room Reviews
  {
    user: users.find_by(name: "Sarah Johnson"),
    room: rooms.find_by(listing_name: "Manhattan Cozy Office"),
    comment: "Perfect location in Manhattan! The workspace is clean, quiet, and has everything I need. Great WiFi and the manager is very helpful. Highly recommend!",
    star: 5
  },
  {
    user: users.find_by(name: "Mike Chen"),
    room: rooms.find_by(listing_name: "Manhattan Cozy Office"),
    comment: "Excellent workspace with amazing views. The facilities are top-notch and the price is reasonable for Manhattan. Will definitely book again!",
    star: 5
  },
  {
    user: users.find_by(name: "Emma Wilson"),
    room: rooms.find_by(listing_name: "Brooklyn Creative Space"),
    comment: "Love the creative vibe here! Perfect for freelancers and small teams. The shared table setup encourages collaboration. Great coffee nearby too!",
    star: 4
  },
  {
    user: users.find_by(name: "David Brown"),
    room: rooms.find_by(listing_name: "Brooklyn Creative Space"),
    comment: "Great value for money in Brooklyn. The space is comfortable and the owner is very accommodating. Perfect for my remote work needs.",
    star: 4
  },
  
  # Kolkata Room Reviews
  {
    user: users.find_by(name: "Lisa Garcia"),
    room: rooms.find_by(listing_name: "Kolkata Business Center"),
    comment: "Professional workspace in the heart of Kolkata. Excellent facilities and very clean. The conference room is perfect for client meetings.",
    star: 5
  },
  {
    user: users.find_by(name: "James Taylor"),
    room: rooms.find_by(listing_name: "Kolkata Business Center"),
    comment: "Great business center with all amenities. The security is excellent and the staff is very professional. Highly recommended for business travelers.",
    star: 5
  },
  {
    user: users.find_by(name: "Anna Rodriguez"),
    room: rooms.find_by(listing_name: "Kolkata Home Office"),
    comment: "Cozy and comfortable home office space. Perfect for quiet work sessions. The owner is very friendly and the location is convenient.",
    star: 4
  },
  {
    user: users.find_by(name: "Robert Lee"),
    room: rooms.find_by(listing_name: "Kolkata Home Office"),
    comment: "Simple but effective workspace. Good for focused work. The price is very reasonable and the WiFi is reliable.",
    star: 3
  },
  
  # Bangkok Room Reviews
  {
    user: users.find_by(name: "Sarah Johnson"),
    room: rooms.find_by(listing_name: "Bangkok Digital Nomad Hub"),
    comment: "Perfect for digital nomads! Great community of remote workers. The facilities are modern and the location is ideal for exploring Bangkok.",
    star: 5
  },
  {
    user: users.find_by(name: "Mike Chen"),
    room: rooms.find_by(listing_name: "Bangkok Digital Nomad Hub"),
    comment: "Amazing workspace with a great community. Met many fellow digital nomads here. The shared table setup is perfect for networking.",
    star: 5
  },
  {
    user: users.find_by(name: "Emma Wilson"),
    room: rooms.find_by(listing_name: "Bangkok Digital Nomad Hub"),
    comment: "Love the international vibe here! Great place to work and meet people from around the world. The facilities are excellent.",
    star: 4
  },
  {
    user: users.find_by(name: "David Brown"),
    room: rooms.find_by(listing_name: "Bangkok Quiet Workspace"),
    comment: "Peaceful workspace away from the city noise. Perfect for focused work. The owner is very accommodating and the space is well-maintained.",
    star: 4
  },
  {
    user: users.find_by(name: "Lisa Garcia"),
    room: rooms.find_by(listing_name: "Bangkok Quiet Workspace"),
    comment: "Great quiet space for deep work. The location is convenient and the price is very reasonable. Will definitely return!",
    star: 4
  },
  {
    user: users.find_by(name: "James Taylor"),
    room: rooms.find_by(listing_name: "Bangkok Quiet Workspace"),
    comment: "Simple but effective workspace. Good for getting work done without distractions. The WiFi is reliable and the space is clean.",
    star: 5
  },
  
  # Seattle Room Reviews
  {
    user: users.find_by(name: "Yuki Tanaka"),
    room: rooms.find_by(listing_name: "Seattle Tech Hub"),
    comment: "Perfect workspace for tech professionals! Great location in the heart of Seattle's tech district. All amenities are top-notch.",
    star: 5
  },
  {
    user: users.find_by(name: "Min Park"),
    room: rooms.find_by(listing_name: "Seattle Tech Hub"),
    comment: "Excellent facilities and very professional environment. The conference rooms are perfect for client meetings. Highly recommended!",
    star: 5
  },
  {
    user: users.find_by(name: "Hans Mueller"),
    room: rooms.find_by(listing_name: "Seattle Coffee Workspace"),
    comment: "Love the coffee shop atmosphere! Great place to work with excellent coffee and city views. Perfect for casual work sessions.",
    star: 4
  },
  {
    user: users.find_by(name: "Sophie Martin"),
    room: rooms.find_by(listing_name: "Seattle Waterfront Office"),
    comment: "Stunning waterfront views! Premium workspace with all the amenities you need. The location is perfect for impressing clients.",
    star: 5
  },
  {
    user: users.find_by(name: "Pierre Dubois"),
    room: rooms.find_by(listing_name: "Seattle University District"),
    comment: "Great student-friendly workspace near UW. Affordable and comfortable. Perfect for studying and group projects.",
    star: 4
  },
  
  # Tokyo Room Reviews
  {
    user: users.find_by(name: "Alex Thompson"),
    room: rooms.find_by(listing_name: "Tokyo Shibuya Tech Space"),
    comment: "Modern and professional workspace in the heart of Shibuya. Perfect for tech meetings and presentations. Excellent facilities!",
    star: 5
  },
  {
    user: users.find_by(name: "Sarah Johnson"),
    room: rooms.find_by(listing_name: "Tokyo Ginza Business Center"),
    comment: "Luxury workspace in prestigious Ginza! Perfect for high-end business meetings. The service is impeccable and facilities are world-class.",
    star: 5
  },
  {
    user: users.find_by(name: "Mike Chen"),
    room: rooms.find_by(listing_name: "Tokyo Harajuku Creative Hub"),
    comment: "Creative and trendy workspace in Harajuku! Great for designers and creative professionals. Love the artistic atmosphere.",
    star: 4
  },
  {
    user: users.find_by(name: "Emma Wilson"),
    room: rooms.find_by(listing_name: "Tokyo Akihabara Gaming Space"),
    comment: "Perfect for gaming and tech enthusiasts! Located in the electronics district. Great for gaming content creators and developers.",
    star: 4
  },
  {
    user: users.find_by(name: "David Brown"),
    room: rooms.find_by(listing_name: "Tokyo Roppongi Hills Office"),
    comment: "Luxury workspace with amazing city skyline views! Perfect for executive meetings. The facilities are absolutely top-tier.",
    star: 5
  },
  
  # Vancouver Room Reviews
  {
    user: users.find_by(name: "Lisa Garcia"),
    room: rooms.find_by(listing_name: "Vancouver Downtown Tech Hub"),
    comment: "Excellent tech workspace in downtown Vancouver! Modern facilities and great location. Perfect for tech startups and professionals.",
    star: 5
  },
  {
    user: users.find_by(name: "James Taylor"),
    room: rooms.find_by(listing_name: "Vancouver Gastown Creative"),
    comment: "Love the historic Gastown location! Creative workspace with character. Perfect for artists and creative professionals.",
    star: 4
  },
  {
    user: users.find_by(name: "Anna Rodriguez"),
    room: rooms.find_by(listing_name: "Vancouver West End Cozy"),
    comment: "Cozy and quiet workspace in residential area. Perfect for focused work. The neighborhood is beautiful and peaceful.",
    star: 4
  },
  {
    user: users.find_by(name: "Robert Lee"),
    room: rooms.find_by(listing_name: "Vancouver Yaletown Business"),
    comment: "Professional business workspace in trendy Yaletown. Great location and excellent facilities. Perfect for business meetings.",
    star: 5
  },
  {
    user: users.find_by(name: "Yuki Tanaka"),
    room: rooms.find_by(listing_name: "Vancouver Kitsilano Beach Workspace"),
    comment: "Relaxed workspace near the beach! Great ocean views and casual atmosphere. Perfect for creative work and inspiration.",
    star: 4
  },

  # Los Angeles Room Reviews
  {
    user: users.find_by(name: "Sarah Johnson"),
    room: rooms.find_by(listing_name: "LA Hollywood Creative Studio"),
    comment: "Perfect for creative professionals! Great location in Hollywood. The workspace is modern and has everything you need for your creative work.",
    star: 5
  },
  {
    user: users.find_by(name: "Mike Chen"),
    room: rooms.find_by(listing_name: "LA Santa Monica Tech Hub"),
    comment: "Modern and convenient workspace near the beach. Great for tech professionals and digital nomads. The facilities are excellent.",
    star: 5
  },
  {
    user: users.find_by(name: "Emma Wilson"),
    room: rooms.find_by(listing_name: "LA Downtown Business Center"),
    comment: "Professional and spacious workspace in downtown LA. Perfect for business meetings and team collaboration. The location is ideal.",
    star: 5
  },
  {
    user: users.find_by(name: "David Brown"),
    room: rooms.find_by(listing_name: "LA Venice Beach Cozy"),
    comment: "Cozy and comfortable workspace in a trendy neighborhood. Perfect for freelancers and remote workers. The location is perfect.",
    star: 4
  },
  {
    user: users.find_by(name: "Lisa Garcia"),
    room: rooms.find_by(listing_name: "LA Beverly Hills Luxury"),
    comment: "Luxury workspace in Beverly Hills! Perfect for high-end professionals and executives. The facilities are absolutely top-tier.",
    star: 5
  },
  {
    user: users.find_by(name: "James Taylor"),
    room: rooms.find_by(listing_name: "LA Venice Beach Cozy"),
    comment: "Simple but effective workspace in a beautiful neighborhood. Great for focused work. The location is perfect.",
    star: 4
  },
  {
    user: users.find_by(name: "Anna Rodriguez"),
    room: rooms.find_by(listing_name: "LA Downtown Business Center"),
    comment: "Professional and spacious workspace in downtown LA. Perfect for business meetings and team collaboration. The location is ideal.",
    star: 5
  },
  {
    user: users.find_by(name: "Robert Lee"),
    room: rooms.find_by(listing_name: "LA Venice Beach Cozy"),
    comment: "Cozy and comfortable workspace in a trendy neighborhood. Perfect for freelancers and remote workers. The location is perfect.",
    star: 4
  },
  {
    user: users.find_by(name: "Yuki Tanaka"),
    room: rooms.find_by(listing_name: "LA Beverly Hills Luxury"),
    comment: "Luxury workspace in Beverly Hills! Perfect for high-end professionals and executives. The facilities are absolutely top-tier.",
    star: 5
  },

  # Toronto Room Reviews
  {
    user: users.find_by(name: "Min Park"),
    room: rooms.find_by(listing_name: "Toronto Downtown Tech Space"),
    comment: "Excellent tech workspace in downtown Toronto! Modern facilities and great location. Perfect for tech startups and professionals.",
    star: 5
  },
  {
    user: users.find_by(name: "Hans Mueller"),
    room: rooms.find_by(listing_name: "Toronto Queen West Creative"),
    comment: "Creative and trendy workspace in Queen West! Great for designers and creative professionals. Love the artistic atmosphere.",
    star: 4
  },
  {
    user: users.find_by(name: "Sophie Martin"),
    room: rooms.find_by(listing_name: "Toronto Financial District"),
    comment: "Professional and spacious workspace in Toronto's financial district. Perfect for business meetings and team collaboration. The location is ideal.",
    star: 5
  },
  {
    user: users.find_by(name: "Pierre Dubois"),
    room: rooms.find_by(listing_name: "Toronto Kensington Market"),
    comment: "Unique and eclectic workspace in Kensington Market! Perfect for creative professionals and digital nomads. The location is perfect.",
    star: 4
  },
  {
    user: users.find_by(name: "Alex Thompson"),
    room: rooms.find_by(listing_name: "Toronto Harbourfront Office"),
    comment: "Premium workspace with lake views at Harbourfront! Perfect for high-end professionals and executives. The facilities are absolutely top-tier.",
    star: 5
  }
]

# Create reviews with varied dates
reviews_data.each_with_index do |review_data, index|
  if review_data[:user] && review_data[:room]
    # Generate more varied dates between 2023-2025, before July 10
    year = [2023, 2024, 2025].sample
    month = rand(1..6) # January to June
    day = rand(1..28) # Avoid month/day issues
    
    # Add some time variation to avoid same timestamps
    hour = rand(0..23)
    minute = rand(0..59)
    second = rand(0..59)
    
    review = Review.create!(
      user: review_data[:user],
      room: review_data[:room],
      comment: review_data[:comment],
      star: review_data[:star],
      created_at: DateTime.new(year, month, day, hour, minute, second)
    )
    puts "Created review for #{review_data[:room].listing_name} by #{review_data[:user].name} on #{review.created_at.strftime('%B %d, %Y at %I:%M %p')} with #{review.star} stars"
  else
    puts "Skipping review - user or room not found"
  end
end

puts "Seed data created successfully!"
puts "Created #{User.count} users"
puts "Created #{Room.count} rooms"
puts "Created #{Review.count} reviews"