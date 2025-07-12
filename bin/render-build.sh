#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
npm install
bundle exec rails importmap:install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

# Always run seeds to ensure all data is present
echo "Running database seeds..."
bundle exec rake db:seed_production