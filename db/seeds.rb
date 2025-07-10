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
    star: 3
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