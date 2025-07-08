source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.3'
# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 1.5'
# Use Puma as the app server
gem 'puma', '~> 6.4'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.1'
# Use importmap-rails for JavaScript bundling
gem 'importmap-rails', '~> 2.1'
# Use Turbo for navigation
gem 'turbo-rails', '~> 2.0'
# Use Stimulus for JavaScript controllers
gem 'stimulus-rails', '~> 1.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'

gem 'aws-sdk-s3', '~> 1.150'

gem 'geocoder', '~> 1.8'

gem 'devise', '~> 4.9'

gem 'ransack', '~> 4.1'

gem 'pagy', '~> 6.0'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1'

gem 'omniauth-facebook', '~> 9.0'
gem 'omniauth-google-oauth2', '~> 1.1'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.16.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.2.0'
  gem 'listen', '~> 3.8'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.39'
  gem 'selenium-webdriver', '~> 4.15'
  # Easy installation and use of web drivers to run system tests with browsers
  # gem 'webdrivers', '~> 5.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
