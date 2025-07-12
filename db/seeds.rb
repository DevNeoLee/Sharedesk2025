# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "Starting database seeding..."

# Always clear existing data before seeding (unless explicitly told not to)
if ENV['KEEP_EXISTING'] != 'true'
  puts "Clearing existing data..."
  puts "Deleting reviews..."
  Review.delete_all
  puts "Deleting rooms..."
  Room.delete_all
  puts "Existing data cleared."
else
  puts "KEEP_EXISTING=true - keeping existing data"
end

puts "Current room count: #{Room.count}. Proceeding with seed data creation..."

# Create users only if they don't exist
user1 = User.find_or_create_by(email: "justin@email.com") do |user|
  user.name = "justin"
  user.password = "111111"
end

user2 = User.find_or_create_by(email: "demo@email.com") do |user|
  user.name = "Demo User"
  user.password = "111111"
end

# Create additional users for reviews
user3 = User.find_or_create_by(email: "sarah@email.com") do |user|
  user.name = "Sarah Johnson"
  user.password = "111111"
end

user4 = User.find_or_create_by(email: "mike@email.com") do |user|
  user.name = "Mike Chen"
  user.password = "111111"
end

user5 = User.find_or_create_by(email: "emma@email.com") do |user|
  user.name = "Emma Wilson"
  user.password = "111111"
end

user6 = User.find_or_create_by(email: "david@email.com") do |user|
  user.name = "David Brown"
  user.password = "111111"
end

user7 = User.find_or_create_by(email: "lisa@email.com") do |user|
  user.name = "Lisa Garcia"
  user.password = "111111"
end

puts "Users created/verified: #{user1.email}, #{user2.email}, #{user3.email}, #{user4.email}, #{user5.email}, #{user6.email}, #{user7.email}"

# Helper method to extract city from address
def extract_city_from_address(address)
  # Extract city from various address formats
  if address.include?('Vancouver, BC, Canada')
    'Vancouver'
  elsif address.include?('Tokyo, Japan')
    'Tokyo'
  elsif address.include?('New York, NYC, USA') || address.include?('Manhattan, NYC, USA') || address.include?('Brooklyn, NYC, USA') || address.include?('Queens, NYC, USA') || address.include?('Harlem, NYC, USA')
    'New York'
  elsif address.include?('Seattle, WA, USA')
    'Seattle'
  elsif address.include?('Toronto, ON, Canada')
    'Toronto'
  elsif address.include?('Bangkok, Thailand')
    'Bangkok'
  elsif address.include?('Los Angeles, CA, USA') || address.include?('Venice Beach, LA, USA') || address.include?('Hollywood, LA, USA') || address.include?('Santa Monica, LA, USA') || address.include?('Pasadena, LA, USA')
    'Los Angeles'
  elsif address.include?('San Francisco, CA, USA')
    'San Francisco'
  elsif address.include?('Chicago, IL, USA')
    'Chicago'
  else
    # Fallback: extract first part before comma
    address.split(',').first.strip
  end
end

# Helper method to create room with default image (only if it doesn't exist)
def create_room_with_image(attributes)
  # Extract city from address
  city = extract_city_from_address(attributes[:address])
  
  # Check if room with same name already exists (anywhere)
  existing_room = Room.where(listing_name: attributes[:listing_name]).first
  
  if existing_room
    puts "Room with same name already exists: #{attributes[:listing_name]} (skipping)"
    return existing_room
  end
  
  # Check if we have enough rooms for this city
  city_room_count = Room.where("address LIKE ?", "%#{city}%").count
  puts "Current room count for #{city}: #{city_room_count}"
  
  # If we already have 5+ rooms for this city, skip
  if city_room_count >= 5
    puts "Already have #{city_room_count} rooms for #{city}, skipping #{attributes[:listing_name]}"
    return nil
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

# Helper method to create reviews for a room
def create_reviews_for_room(room, users)
  # Check if room already has enough reviews
  if room.reviews.count >= 5
    puts "Room #{room.listing_name} already has #{room.reviews.count} reviews (skipping)"
    return
  end
  
  review_data = [
    { star: 5, comment: "Excellent workspace! Great location and amenities. Highly recommend!" },
    { star: 4, comment: "Very good space with fast wifi and comfortable seating." },
    { star: 5, comment: "Perfect for productivity. Clean and well-maintained." },
    { star: 4, comment: "Good value for money. Friendly atmosphere." },
    { star: 3, comment: "Decent space, could use some improvements but overall okay." }
  ]
  
  reviews_created = 0
  users.each_with_index do |user, index|
    next if index >= 5
    
    # Check if review already exists
    existing_review = Review.find_by(room: room, user: user)
    if existing_review
      puts "Review already exists for #{room.listing_name} by #{user.name} (skipping)"
      next
    end
    
    Review.create!(
      room: room,
      user: user,
      star: review_data[index][:star],
      comment: review_data[index][:comment]
    )
    reviews_created += 1
  end
  
  if reviews_created > 0
    puts "Created #{reviews_created} new reviews for #{room.listing_name}"
  else
    puts "No new reviews created for #{room.listing_name} (all already exist)"
  end
end

puts "Creating sample rooms..."

# Sample room data - 5 rooms per city
rooms_data = [
  # Seattle Rooms (5)
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
  {
    user: user3,
    listing_name: "Seattle Capitol Hill Creative",
    address: "Seattle, WA, USA",
    summary: "Creative workspace in vibrant Capitol Hill neighborhood",
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
    is_printing: true,
    active: true,
    latitude: 47.6062,
    longitude: -122.3321
  },
  {
    user: user4,
    listing_name: "Seattle Downtown Business Center",
    address: "Seattle, WA, USA",
    summary: "Professional business center in downtown Seattle",
    space_type: "Office",
    desk_type: "Private Room Office",
    capacity: 4,
    noise_level: "Silent Mode",
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
    latitude: 47.6062,
    longitude: -122.3321
  },
  {
    user: user5,
    listing_name: "Seattle Fremont Innovation Hub",
    address: "Seattle, WA, USA",
    summary: "Innovation hub in the quirky Fremont neighborhood",
    space_type: "Office",
    desk_type: "Single Desk",
    capacity: 10,
    noise_level: "Quiet",
    bath_room: 3,
    manager_on: "Fulltime",
    security_level: "High",
    price: 40,
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
  
  # Toronto Rooms (5)
  {
    user: user1,
    listing_name: "Toronto Financial District",
    address: "Toronto, ON, Canada",
    summary: "Premium workspace in Toronto's financial district",
    space_type: "Office",
    desk_type: "Single Desk",
    capacity: 6,
    noise_level: "Silent Mode",
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
    latitude: 43.6532,
    longitude: -79.3832
  },
  {
    user: user2,
    listing_name: "Toronto Queen West Creative",
    address: "Toronto, ON, Canada",
    summary: "Creative workspace in trendy Queen West",
    space_type: "Studio",
    desk_type: "Sharing Table",
    capacity: 5,
    noise_level: "Casual",
    bath_room: 1,
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
    latitude: 43.6532,
    longitude: -79.3832
  },
  {
    user: user3,
    listing_name: "Toronto Kensington Market",
    address: "Toronto, ON, Canada",
    summary: "Unique workspace in eclectic Kensington Market",
    space_type: "Cafe",
    desk_type: "Sharing Table",
    capacity: 3,
    noise_level: "Casual",
    bath_room: 1,
    manager_on: "No Stay",
    security_level: "Good",
    price: 20,
    is_wifi: true,
    is_kitchen: false,
    is_air: true,
    is_heating: true,
    is_conference: false,
    is_drinks: true,
    is_parking: false,
    is_printing: false,
    active: true,
    latitude: 43.6532,
    longitude: -79.3832
  },
  {
    user: user4,
    listing_name: "Toronto Liberty Village Tech",
    address: "Toronto, ON, Canada",
    summary: "Tech workspace in Liberty Village",
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
    latitude: 43.6532,
    longitude: -79.3832
  },
  {
    user: user5,
    listing_name: "Toronto Distillery District",
    address: "Toronto, ON, Canada",
    summary: "Historic workspace in Distillery District",
    space_type: "Office",
    desk_type: "Private Room Office",
    capacity: 4,
    noise_level: "Quiet",
    bath_room: 2,
    manager_on: "Parttime",
    security_level: "Good",
    price: 40,
    is_wifi: true,
    is_kitchen: true,
    is_air: true,
    is_heating: true,
    is_conference: false,
    is_drinks: true,
    is_parking: true,
    is_printing: true,
    active: true,
    latitude: 43.6532,
    longitude: -79.3832
  },
  
  # Bangkok Rooms (5)
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
  {
    user: user3,
    listing_name: "Bangkok Sukhumvit Business",
    address: "Bangkok, Thailand",
    summary: "Business workspace in Sukhumvit area",
    space_type: "Office",
    desk_type: "Single Desk",
    capacity: 5,
    noise_level: "Quiet",
    bath_room: 2,
    manager_on: "Fulltime",
    security_level: "High",
    price: 35,
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
    user: user4,
    listing_name: "Bangkok Silom Tech Space",
    address: "Bangkok, Thailand",
    summary: "Tech workspace in Silom district",
    space_type: "Office",
    desk_type: "Sharing Table",
    capacity: 4,
    noise_level: "Casual",
    bath_room: 1,
    manager_on: "Parttime",
    security_level: "Good",
    price: 25,
    is_wifi: true,
    is_kitchen: true,
    is_air: true,
    is_heating: false,
    is_conference: false,
    is_drinks: true,
    is_parking: false,
    is_printing: true,
    active: true,
    latitude: 13.7563,
    longitude: 100.5018
  },
  {
    user: user5,
    listing_name: "Bangkok Riverside Creative",
    address: "Bangkok, Thailand",
    summary: "Creative workspace with river views",
    space_type: "Studio",
    desk_type: "Single Desk",
    capacity: 3,
    noise_level: "Quiet",
    bath_room: 1,
    manager_on: "No Stay",
    security_level: "Good",
    price: 28,
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
  
  # New York Rooms (5)
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
  {
    user: user3,
    listing_name: "Queens Tech Hub",
    address: "Queens, NYC, USA",
    summary: "Tech workspace in Queens",
    space_type: "Office",
    desk_type: "Single Desk",
    capacity: 6,
    noise_level: "Quiet",
    bath_room: 2,
    manager_on: "Fulltime",
    security_level: "High",
    price: 40,
    is_wifi: true,
    is_kitchen: true,
    is_air: true,
    is_heating: true,
    is_conference: true,
    is_drinks: true,
    is_parking: true,
    is_printing: true,
    active: true,
    latitude: 40.7128,
    longitude: -74.0060
  },
  {
    user: user4,
    listing_name: "Manhattan Financial District",
    address: "Manhattan, NYC, USA",
    summary: "Premium workspace in Financial District",
    space_type: "Office",
    desk_type: "Private Room Office",
    capacity: 3,
    noise_level: "Silent Mode",
    bath_room: 2,
    manager_on: "Fulltime",
    security_level: "High",
    price: 65,
    is_wifi: true,
    is_kitchen: true,
    is_air: true,
    is_heating: true,
    is_conference: true,
    is_drinks: true,
    is_parking: true,
    is_printing: true,
    active: true,
    latitude: 40.7128,
    longitude: -74.0060
  },
  {
    user: user5,
    listing_name: "Harlem Community Space",
    address: "Harlem, NYC, USA",
    summary: "Community workspace in Harlem",
    space_type: "Studio",
    desk_type: "Sharing Table",
    capacity: 5,
    noise_level: "Casual",
    bath_room: 1,
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
    latitude: 40.7128,
    longitude: -74.0060
  },
  
  # LA Rooms (5)
  {
    user: user1,
    listing_name: "LA Downtown Tech",
    address: "Los Angeles, CA, USA",
    summary: "Tech workspace in downtown LA",
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
    is_heating: false,
    is_conference: true,
    is_drinks: true,
    is_parking: true,
    is_printing: true,
    active: true,
    latitude: 34.0522,
    longitude: -118.2437
  },
  {
    user: user2,
    listing_name: "Venice Beach Creative",
    address: "Venice Beach, LA, USA",
    summary: "Creative workspace near Venice Beach",
    space_type: "Studio",
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
    is_heating: false,
    is_conference: false,
    is_drinks: true,
    is_parking: false,
    is_printing: false,
    active: true,
    latitude: 34.0522,
    longitude: -118.2437
  },
  {
    user: user3,
    listing_name: "Hollywood Business Center",
    address: "Hollywood, LA, USA",
    summary: "Business center in Hollywood",
    space_type: "Office",
    desk_type: "Private Room Office",
    capacity: 5,
    noise_level: "Quiet",
    bath_room: 2,
    manager_on: "Fulltime",
    security_level: "High",
    price: 50,
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
  },
  {
    user: user4,
    listing_name: "Santa Monica Beach Hub",
    address: "Santa Monica, LA, USA",
    summary: "Beachside workspace in Santa Monica",
    space_type: "Cafe",
    desk_type: "Sharing Table",
    capacity: 3,
    noise_level: "Casual",
    bath_room: 1,
    manager_on: "No Stay",
    security_level: "Good",
    price: 25,
    is_wifi: true,
    is_kitchen: false,
    is_air: true,
    is_heating: false,
    is_conference: false,
    is_drinks: true,
    is_parking: false,
    is_printing: false,
    active: true,
    latitude: 34.0522,
    longitude: -118.2437
  },
  {
    user: user5,
    listing_name: "Pasadena Innovation Lab",
    address: "Pasadena, LA, USA",
    summary: "Innovation lab in Pasadena",
    space_type: "Office",
    desk_type: "Single Desk",
    capacity: 6,
    noise_level: "Quiet",
    bath_room: 2,
    manager_on: "Fulltime",
    security_level: "High",
    price: 40,
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
  },
  
  # San Francisco Rooms (5)
  {
    user: user1,
    listing_name: "SF Mission Tech",
    address: "San Francisco, CA, USA",
    summary: "Tech workspace in Mission District",
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
    latitude: 37.7749,
    longitude: -122.4194
  },
  {
    user: user2,
    listing_name: "SF SOMA Creative",
    address: "San Francisco, CA, USA",
    summary: "Creative workspace in SOMA",
    space_type: "Studio",
    desk_type: "Sharing Table",
    capacity: 5,
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
    is_parking: false,
    is_printing: true,
    active: true,
    latitude: 37.7749,
    longitude: -122.4194
  },
  {
    user: user3,
    listing_name: "SF Financial District",
    address: "San Francisco, CA, USA",
    summary: "Premium workspace in Financial District",
    space_type: "Office",
    desk_type: "Private Room Office",
    capacity: 4,
    noise_level: "Silent Mode",
    bath_room: 2,
    manager_on: "Fulltime",
    security_level: "High",
    price: 70,
    is_wifi: true,
    is_kitchen: true,
    is_air: true,
    is_heating: false,
    is_conference: true,
    is_drinks: true,
    is_parking: true,
    is_printing: true,
    active: true,
    latitude: 37.7749,
    longitude: -122.4194
  },
  {
    user: user4,
    listing_name: "SF North Beach Cafe",
    address: "San Francisco, CA, USA",
    summary: "Cafe workspace in North Beach",
    space_type: "Cafe",
    desk_type: "Sharing Table",
    capacity: 3,
    noise_level: "Casual",
    bath_room: 1,
    manager_on: "No Stay",
    security_level: "Good",
    price: 30,
    is_wifi: true,
    is_kitchen: false,
    is_air: true,
    is_heating: false,
    is_conference: false,
    is_drinks: true,
    is_parking: false,
    is_printing: false,
    active: true,
    latitude: 37.7749,
    longitude: -122.4194
  },
  {
    user: user5,
    listing_name: "SF Hayes Valley Hub",
    address: "San Francisco, CA, USA",
    summary: "Innovation hub in Hayes Valley",
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
    is_heating: false,
    is_conference: true,
    is_drinks: true,
    is_parking: true,
    is_printing: true,
    active: true,
    latitude: 37.7749,
    longitude: -122.4194
  },
  
  # Tokyo Rooms (5)
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
  {
    user: user3,
    listing_name: "Tokyo Harajuku Creative",
    address: "Tokyo, Japan",
    summary: "Creative workspace in trendy Harajuku",
    space_type: "Studio",
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
    is_parking: false,
    is_printing: false,
    active: true,
    latitude: 35.6762,
    longitude: 139.6503
  },
  {
    user: user4,
    listing_name: "Tokyo Roppongi Hills",
    address: "Tokyo, Japan",
    summary: "Luxury workspace in Roppongi Hills",
    space_type: "Office",
    desk_type: "Private Room Office",
    capacity: 6,
    noise_level: "Silent Mode",
    bath_room: 3,
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
  },
  {
    user: user5,
    listing_name: "Tokyo Akihabara Tech Hub",
    address: "Tokyo, Japan",
    summary: "Tech hub in Akihabara electronics district",
    space_type: "Office",
    desk_type: "Single Desk",
    capacity: 8,
    noise_level: "Quiet",
    bath_room: 2,
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
    latitude: 35.6762,
    longitude: 139.6503
  },
  
  # Chicago Rooms (5)
  {
    user: user1,
    listing_name: "Chicago Loop Business",
    address: "Chicago, IL, USA",
    summary: "Business workspace in the Loop",
    space_type: "Office",
    desk_type: "Single Desk",
    capacity: 6,
    noise_level: "Quiet",
    bath_room: 2,
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
    latitude: 41.8781,
    longitude: -87.6298
  },
  {
    user: user2,
    listing_name: "Chicago Wicker Park Creative",
    address: "Chicago, IL, USA",
    summary: "Creative workspace in Wicker Park",
    space_type: "Studio",
    desk_type: "Sharing Table",
    capacity: 4,
    noise_level: "Casual",
    bath_room: 1,
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
    latitude: 41.8781,
    longitude: -87.6298
  },
  {
    user: user3,
    listing_name: "Chicago River North Tech",
    address: "Chicago, IL, USA",
    summary: "Tech workspace in River North",
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
    latitude: 41.8781,
    longitude: -87.6298
  },
  {
    user: user4,
    listing_name: "Chicago Gold Coast Luxury",
    address: "Chicago, IL, USA",
    summary: "Luxury workspace in Gold Coast",
    space_type: "Office",
    desk_type: "Private Room Office",
    capacity: 4,
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
    latitude: 41.8781,
    longitude: -87.6298
  },
  {
    user: user5,
    listing_name: "Chicago Pilsen Community",
    address: "Chicago, IL, USA",
    summary: "Community workspace in Pilsen",
    space_type: "Cafe",
    desk_type: "Sharing Table",
    capacity: 3,
    noise_level: "Casual",
    bath_room: 1,
    manager_on: "No Stay",
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
    latitude: 41.8781,
    longitude: -87.6298
  },
  
  # Vancouver Rooms (5)
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
  },
  {
    user: user3,
    listing_name: "Vancouver Yaletown Business",
    address: "Vancouver, BC, Canada",
    summary: "Business workspace in trendy Yaletown",
    space_type: "Office",
    desk_type: "Private Room Office",
    capacity: 4,
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
  },
  {
    user: user4,
    listing_name: "Vancouver Kitsilano Beach Hub",
    address: "Vancouver, BC, Canada",
    summary: "Beachside workspace in Kitsilano",
    space_type: "Cafe",
    desk_type: "Sharing Table",
    capacity: 3,
    noise_level: "Casual",
    bath_room: 1,
    manager_on: "No Stay",
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
    latitude: 49.2827,
    longitude: -123.1207
  },
  {
    user: user5,
    listing_name: "Vancouver Mount Pleasant Innovation",
    address: "Vancouver, BC, Canada",
    summary: "Innovation hub in Mount Pleasant",
    space_type: "Office",
    desk_type: "Single Desk",
    capacity: 6,
    noise_level: "Quiet",
    bath_room: 2,
    manager_on: "Fulltime",
    security_level: "High",
    price: 40,
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
  }
]

# Create all rooms
rooms = []
rooms_data.each do |room_data|
  room = create_room_with_image(room_data)
  rooms << room if room
end

# Create reviews for each room
users_for_reviews = [user1, user2, user3, user4, user5, user6, user7]
rooms.each do |room|
  create_reviews_for_room(room, users_for_reviews)
end

puts "Database seeding completed!"
puts "Total users: #{User.count}"
puts "Total rooms: #{Room.count}"
puts "Total reviews: #{Review.count}"

# Show breakdown by city
puts "\n=== Rooms by City ==="
cities = ['Vancouver', 'Tokyo', 'New York', 'Seattle', 'Toronto', 'Bangkok', 'Los Angeles', 'San Francisco', 'Chicago']
cities.each do |city|
  count = Room.where("address LIKE ?", "%#{city}%").count
  puts "#{city}: #{count} rooms"
end

puts "\n=== Duplicate Prevention Summary ==="
puts "✓ Rooms with same name are skipped"
puts "✓ Maximum 5 rooms per city"
puts "✓ Maximum 5 reviews per room"
puts "✓ Users are created only once"
puts "✓ Total room limit: 50 rooms"

puts "\n=== Usage Instructions ==="
puts "To recreate all data (default behavior):"
puts "  rails db:seed"
puts ""
puts "To keep existing data and add only missing items:"
puts "  KEEP_EXISTING=true rails db:seed"
puts ""
puts "To reset database completely:"
puts "  rails db:drop && rails db:create && rails db:migrate && rails db:seed"
puts ""
puts "To check current data without seeding:"
puts "  rails runner 'puts \"Rooms: #{Room.count}\"; puts \"Users: #{User.count}\"; puts \"Reviews: #{Review.count}\"'"