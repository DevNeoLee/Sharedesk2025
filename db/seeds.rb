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