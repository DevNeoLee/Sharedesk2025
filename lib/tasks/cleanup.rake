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