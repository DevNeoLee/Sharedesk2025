# This file contains only NEW data to be added to existing database
# Use this when you want to add new rooms, users, or other data without affecting existing data

puts "Adding new data to existing database..."

# Get existing users
user1 = User.find_by(email: "justin@email.com")
user2 = User.find_by(email: "demo@email.com")

unless user1 && user2
  puts "Required users not found. Please run full seeds first."
  exit
end

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
    puts "Created NEW room: #{attributes[:listing_name]}"
    room
  else
    puts "Error creating room: #{attributes[:listing_name]}"
    nil
  end
rescue => e
  puts "Error creating room #{attributes[:listing_name]}: #{e.message}"
  nil
end

# NEW DATA - Add only new rooms here
new_rooms_data = [
  # Add new rooms here when needed
  # Example:
  # {
  #   user: user1,
  #   listing_name: "New City Workspace",
  #   address: "New City, Country",
  #   summary: "Brand new workspace",
  #   space_type: "Office",
  #   desk_type: "Single Desk",
  #   capacity: 4,
  #   noise_level: "Quiet",
  #   bath_room: 2,
  #   manager_on: "Fulltime",
  #   security_level: "High",
  #   price: 40,
  #   is_wifi: true,
  #   is_kitchen: true,
  #   is_air: true,
  #   is_heating: true,
  #   is_conference: true,
  #   is_drinks: true,
  #   is_parking: true,
  #   is_printing: true,
  #   active: true,
  #   latitude: 0.0,
  #   longitude: 0.0
  # }
]

# Create new rooms
new_rooms_count = 0
new_rooms_data.each do |room_data|
  room = create_room_with_image(room_data)
  new_rooms_count += 1 if room && room.created_at > 1.minute.ago
end

puts "New data addition completed!"
puts "New rooms created: #{new_rooms_count}"
puts "Total users: #{User.count}"
puts "Total rooms: #{Room.count}" 