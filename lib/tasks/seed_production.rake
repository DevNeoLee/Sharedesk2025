namespace :db do
  desc "Seed production database safely"
  task seed_production: :environment do
    puts "Starting production seeding..."
    
    # Check if we're in production
    if Rails.env.production?
      puts "Production environment detected"
      
      # Always run seeds in production to ensure data consistency
      Rake::Task['db:seed'].invoke
      
      puts "Production seeding completed!"
      puts "Total users: #{User.count}"
      puts "Total rooms: #{Room.count}"
      puts "Total reviews: #{Review.count}"
    else
      puts "Not in production environment, running regular seeds..."
      Rake::Task['db:seed'].invoke
    end
  end
  
  desc "Force seed production database (clears existing data)"
  task force_seed_production: :environment do
    puts "Starting force production seeding..."
    
    if Rails.env.production?
      puts "Production environment detected - clearing existing data..."
      
      # Clear existing data
      Review.delete_all
      Room.delete_all
      puts "Existing data cleared."
      
      # Run seeds
      Rake::Task['db:seed'].invoke
      
      puts "Force production seeding completed!"
      puts "Total users: #{User.count}"
      puts "Total rooms: #{Room.count}"
      puts "Total reviews: #{Review.count}"
      
      # Show breakdown by city
      puts "\n=== Rooms by City ==="
      Room.group(:address).count.each do |address, count|
        puts "#{address}: #{count} rooms"
      end
    else
      puts "Not in production environment, use CLEAR_EXISTING=true rails db:seed instead"
    end
  end
end 