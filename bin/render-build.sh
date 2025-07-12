#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
npm install
bundle exec rails importmap:install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

# Check if this is first deployment or if we need incremental seeding
if bundle exec rails runner "puts Room.count" | grep -q "0"; then
  echo "Database is empty, running full seeds..."
  bundle exec rake db:seed
else
  echo "Database has existing data, running incremental seeds..."
  bundle exec rake db:seed_incremental
fi