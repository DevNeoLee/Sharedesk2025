namespace :maps do
  desc "Check Google Maps API configuration"
  task check_config: :environment do
    puts "=== Google Maps API Configuration Check ==="
    
    # Check environment variable
    api_key = ENV['MAPS_API_KEY']
    if api_key.present?
      puts "✅ MAPS_API_KEY is set"
      puts "   Key starts with: #{api_key[0..10]}..."
    else
      puts "❌ MAPS_API_KEY is not set"
    end
    
    # Check if we're in production
    if Rails.env.production?
      puts "✅ Running in production environment"
      
      # Test API key with a simple request
      if api_key.present?
        puts "Testing API key..."
        test_url = "https://maps.googleapis.com/maps/api/geocode/json?address=test&key=#{api_key}"
        
        begin
          require 'net/http'
          uri = URI(test_url)
          response = Net::HTTP.get_response(uri)
          
          if response.is_a?(Net::HTTPSuccess)
            puts "✅ API key is working"
          elsif response.code == '403'
            puts "❌ API key is invalid or has restrictions"
            puts "   Response: #{response.body}"
          else
            puts "⚠️  API key test returned: #{response.code}"
          end
        rescue => e
          puts "❌ Error testing API key: #{e.message}"
        end
      end
    else
      puts "ℹ️  Running in development environment"
    end
    
    puts "\n=== Recommendations ==="
    puts "1. Check Render.com environment variables"
    puts "2. Verify Google Cloud Console API key settings"
    puts "3. Ensure required APIs are enabled:"
    puts "   - Maps JavaScript API"
    puts "   - Places API"
    puts "   - Geocoding API"
    puts "   - Static Maps API"
    puts "4. Check API key restrictions (HTTP referrers)"
  end
  
  desc "Test Google Maps API endpoints"
  task test_api: :environment do
    puts "=== Testing Google Maps API Endpoints ==="
    
    api_key = ENV['MAPS_API_KEY']
    unless api_key.present?
      puts "❌ MAPS_API_KEY not set"
      return
    end
    
    endpoints = [
      {
        name: "Maps JavaScript API",
        url: "https://maps.googleapis.com/maps/api/js?key=#{api_key}&libraries=places"
      },
      {
        name: "Geocoding API",
        url: "https://maps.googleapis.com/maps/api/geocode/json?address=test&key=#{api_key}"
      },
      {
        name: "Static Maps API",
        url: "https://maps.googleapis.com/maps/api/staticmap?center=40.7128,-74.0060&zoom=13&size=400x400&key=#{api_key}"
      }
    ]
    
    endpoints.each do |endpoint|
      puts "\nTesting #{endpoint[:name]}..."
      begin
        require 'net/http'
        uri = URI(endpoint[:url])
        response = Net::HTTP.get_response(uri)
        
        case response.code
        when '200'
          puts "✅ #{endpoint[:name]} - OK"
        when '403'
          puts "❌ #{endpoint[:name]} - Forbidden (check API key restrictions)"
        else
          puts "⚠️  #{endpoint[:name]} - #{response.code}"
        end
      rescue => e
        puts "❌ #{endpoint[:name]} - Error: #{e.message}"
      end
    end
  end
end 