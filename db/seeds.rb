# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
puts "Removing all movies....."
Movie.destroy_all
puts "Seeding new data....."
5.times do
  Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote, poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: Faker::Number.between(from: 0.0, to: 10.0))
  Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote, poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: Faker::Number.between(from: 0.0, to: 10.0))
  Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote, poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: Faker::Number.between(from: 0.0, to: 10.0))
  Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote, poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: Faker::Number.between(from: 0.0, to: 10.0))
end
puts "Seeding finished, #{Movie.count} movies are created"
