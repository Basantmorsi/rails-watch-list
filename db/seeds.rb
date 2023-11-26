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
# puts "Removing all movies....."
# Movie.destroy_all
# puts "Seeding new data....."
# 5.times do
#   Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote, poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: Faker::Number.between(from: 0.0, to: 10.0))
#   Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote, poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: Faker::Number.between(from: 0.0, to: 10.0))
#   Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote, poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: Faker::Number.between(from: 0.0, to: 10.0))
#   Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote, poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: Faker::Number.between(from: 0.0, to: 10.0))
# end
# puts "Seeding finished, #{Movie.count} movies are created"


# require "open-uri"
# require 'json'

# file = URI.open("https://api.themoviedb.org/3/movie/top_rated")
# puts JSON.parse(file)
require 'uri'
require 'net/http'
require 'json'

url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOGY1M2UxMjU5NmU3NDBjMzQ3MGRhM2E4ZjBiYzQyYSIsInN1YiI6IjY1NWYzYjFkMmIxMTNkMDBjYTRmNzEzMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.38t6LSRkkgJn-vJ2zlboKdDtPROMiliRVz1vIehn95c'

response = http.request(request)
data = JSON.parse(response.body)
if data
  puts "Removing all movies....."
  Movie.destroy_all
  puts "Seeding new data....."
  data['results'].each do |item|
      Movie.create(title: item["title"], overview: item["overview"], poster_url: item["poster_path"], rating: item["vote_average"])

      # {"adult"=>false, "backdrop_path"=>"/zoVeIgKzGJzpdG6Gwnr7iOYfIMU.jpg",
      # "genre_ids"=>[18, 10749], "id"=>11216, "original_language"=>"it",
      # "original_title"=>"Nuovo Cinema Paradiso",
      # "overview"=>"A filmmaker recalls his childhood, when he fell in love with the movies at his village's theater and formed a deep friendship with the theater's projectionist.",
      # "popularity"=>29.596, "poster_path"=>"/8SRUfRUi6x4O68n0VCbDNRa6iGL.jpg",
      # "release_date"=>"1988-11-17",
      # "title"=>"Cinema Paradiso", "video"=>false, "vote_average"=>8.448, "vote_count"=>4016}
  end
  puts "Seeding finished, #{Movie.count} movies are created"
end
