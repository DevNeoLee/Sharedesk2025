namespace :db do
  desc "Clean up duplicate rooms and users from repeated seeding"
  task cleanup_duplicates: :environment do
    puts "Starting cleanup of duplicate data..."
    
    # Clean up duplicate users (keep the first one)
    puts "Cleaning up duplicate users..."
    User.group(:email).having('COUNT(*) > 1').each do |user|
      duplicates = User.where(email: user.email).order(:created_at)
      keep_user = duplicates.first
      duplicates.where.not(id: keep_user.id).destroy_all
      puts "Removed #{duplicates.count - 1} duplicate users for #{user.email}"
    end
    
    # Clean up duplicate rooms (keep the first one for each listing_name + user_id combination)
    puts "Cleaning up duplicate rooms..."
    Room.group(:listing_name, :user_id).having('COUNT(*) > 1').each do |room|
      duplicates = Room.where(listing_name: room.listing_name, user_id: room.user_id).order(:created_at)
      keep_room = duplicates.first
      duplicates.where.not(id: keep_room.id).destroy_all
      puts "Removed #{duplicates.count - 1} duplicate rooms for #{room.listing_name}"
    end
    
    # Clean up orphaned reviews (reviews for deleted rooms)
    puts "Cleaning up orphaned reviews..."
    orphaned_reviews = Review.left_joins(:room).where(rooms: { id: nil })
    orphaned_count = orphaned_reviews.count
    orphaned_reviews.destroy_all
    puts "Removed #{orphaned_count} orphaned reviews"
    
    # Clean up orphaned reservations (reservations for deleted rooms)
    puts "Cleaning up orphaned reservations..."
    orphaned_reservations = Reservation.left_joins(:room).where(rooms: { id: nil })
    orphaned_count = orphaned_reservations.count
    orphaned_reservations.destroy_all
    puts "Removed #{orphaned_count} orphaned reservations"
    
    # Clean up orphaned conversations (conversations with deleted users)
    puts "Cleaning up orphaned conversations..."
    orphaned_conversations = Conversation.left_joins(:sender, :recipient)
                                        .where('users.id IS NULL OR recipients_conversations.id IS NULL')
    orphaned_count = orphaned_conversations.count
    orphaned_conversations.destroy_all
    puts "Removed #{orphaned_count} orphaned conversations"
    
    # Clean up orphaned messages (messages in deleted conversations)
    puts "Cleaning up orphaned messages..."
    orphaned_messages = Message.left_joins(:conversation).where(conversations: { id: nil })
    orphaned_count = orphaned_messages.count
    orphaned_messages.destroy_all
    puts "Removed #{orphaned_count} orphaned messages"
    
    puts "Cleanup completed!"
    puts "Final counts:"
    puts "  Users: #{User.count}"
    puts "  Rooms: #{Room.count}"
    puts "  Reviews: #{Review.count}"
    puts "  Reservations: #{Reservation.count}"
    puts "  Conversations: #{Conversation.count}"
    puts "  Messages: #{Message.count}"
  end
  
  desc "Reset database and seed with clean data"
  task reset_and_seed: :environment do
    puts "This will completely reset the database. Are you sure? (y/N)"
    response = STDIN.gets.chomp.downcase
    
    if response == 'y' || response == 'yes'
      puts "Dropping and recreating database..."
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed'].invoke
      puts "Database reset and seeded successfully!"
    else
      puts "Operation cancelled."
    end
  end
  
    desc "Add only new seed data (incremental seeding)"
  task seed_incremental: :environment do
    puts "Loading new data from seeds_new_data.rb..."
    load Rails.root.join('db', 'seeds_new_data.rb')
  end
    
    # Get existing data for comparison
    existing_users = User.pluck(:email)
    existing_rooms = Room.pluck(:listing_name, :user_id)
    
    puts "Found #{existing_users.count} existing users"
    puts "Found #{existing_rooms.count} existing rooms"
    
    # Create users only if they don't exist
    user1 = User.find_or_create_by(email: "justin@email.com") do |user|
      user.name = "justin"
      user.password = "111111"
      puts "Created new user: justin@email.com"
    end

    user2 = User.find_or_create_by(email: "demo@email.com") do |user|
      user.name = "Demo User"
      user.password = "111111"
      puts "Created new user: demo@email.com"
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

    # Sample room data (same as in seeds.rb)
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

    # Create only new rooms
    new_rooms_count = 0
    rooms_data.each do |room_data|
      room = create_room_with_image(room_data)
      new_rooms_count += 1 if room && room.created_at > 1.minute.ago
    end

    puts "Incremental seeding completed!"
    puts "New rooms created: #{new_rooms_count}"
    puts "Total users: #{User.count}"
    puts "Total rooms: #{Room.count}"
  end
  end
  
  desc "Show current database statistics"
  task stats: :environment do
    puts "Database Statistics:"
    puts "==================="
    puts "Users: #{User.count}"
    puts "Rooms: #{Room.count}"
    puts "Reviews: #{Review.count}"
    puts "Reservations: #{Reservation.count}"
    puts "Conversations: #{Conversation.count}"
    puts "Messages: #{Message.count}"
    
    puts "\nDuplicate Analysis:"
    puts "=================="
    
    # Check for duplicate users
    duplicate_users = User.group(:email).having('COUNT(*) > 1')
    if duplicate_users.any?
      puts "Duplicate users found:"
      duplicate_users.each do |user|
        count = User.where(email: user.email).count
        puts "  #{user.email}: #{count} instances"
      end
    else
      puts "No duplicate users found"
    end
    
    # Check for duplicate rooms
    duplicate_rooms = Room.group(:listing_name, :user_id).having('COUNT(*) > 1')
    if duplicate_rooms.any?
      puts "Duplicate rooms found:"
      duplicate_rooms.each do |room|
        count = Room.where(listing_name: room.listing_name, user_id: room.user_id).count
        puts "  #{room.listing_name} (User: #{room.user.email}): #{count} instances"
      end
    else
      puts "No duplicate rooms found"
    end
  end
end 