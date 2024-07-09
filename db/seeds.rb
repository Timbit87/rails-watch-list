# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
require 'open-uri'

url = 'https://tmdb.lewagon.com/movie/top_rated'
puts "Destroying all previous entries"
Bookmark.destroy_all
Movie.destroy_all
puts "Done"
puts "creating default movies"

response = URI.open(url).read
movies = JSON.parse(response)

puts 'populating database'

movies['results'].each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    rating: movie['vote_average'].round(1),
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}"
  )
end
puts "finished"
