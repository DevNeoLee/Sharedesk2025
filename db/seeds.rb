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