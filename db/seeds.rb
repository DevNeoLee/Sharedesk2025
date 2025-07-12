# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "Starting database seeding..."

# Create users only if they don't exist
user1 = User.find_or_create_by(email: "justin@email.com") do |user|
  user.name = "justin"
  user.password = "111111"
end

user2 = User.find_or_create_by(email: "demo@email.com") do |user|
  user.name = "Demo User"
  user.password = "111111"
end

puts "Users created/verified: #{user1.email}, #{user2.email}"

# Helper method to create room with default image (only if it doesn't exist)
def create_room_with_image(attributes)
  # Check if room already exists by listing_name and user_id
  existing_room = Room.find_by(
    listing_name: attributes[:listing_name],
    user_id: attributes[:user].id
  )
  
  if existing_room
    puts "Room already exists: #{attributes[:listing_name]}"
    return existing_room
  end
  
  room = Room.new(attributes)
  
  # Attach a default image
  begin
    room.images.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.jpg')),
      filename: 'default_room.jpg',
      content_type: 'image/jpeg'
    )
  rescue => e
    puts "Warning: Could not attach image to #{attributes[:listing_name]}: #{e.message}"
  end
  
  if room.save!
    puts "Created room: #{attributes[:listing_name]}"
    room
  else
    puts "Error creating room: #{attributes[:listing_name]}"
    nil
  end
rescue => e
  puts "Error creating room #{attributes[:listing_name]}: #{e.message}"
  nil
end

puts "Creating sample rooms..."

# Sample room data
rooms_data = [
  # NYC Rooms
  {
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
  },
  {
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
  },
  # Kolkata Rooms
  {
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
  },
  {
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
  },
  # Bangkok Rooms
  {
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
  },
  {
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
  },
  # Seattle Rooms
  {
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
  },
  {
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
  },
  # Tokyo Rooms
  {
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
  },
  {
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
  },
  # Vancouver Rooms
  {
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
  },
  {
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
  }
]

# Create all rooms
rooms_data.each do |room_data|
  create_room_with_image(room_data)
end

puts "Database seeding completed!"
puts "Total users: #{User.count}"
puts "Total rooms: #{Room.count}"