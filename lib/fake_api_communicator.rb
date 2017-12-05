require 'rest-client'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'pry'

# Methods for finding character info

def get_character_hash
  all_characters = RestClient.get('https://itunes.apple.com/us/podcast/npr-politics-podcast/id1057255460?mt=2&ign-mpt=uo%3D4')
  # hash = JSON.parse(all_characters)
  binding.pry
  result = {}
    hash["results"].each do |character|
      result[character["name"]] = character
    end
  result
end

get_character_hash

def movie_list(url_list)
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  # and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  url_list.map do |url|
    movie = RestClient.get(url)
    movie_hash = JSON.parse(movie)
    movie_hash["title"]
  end
end

def get_array_of_movies(character)
  character_hash = get_character_hash
  character_hash[character]["films"]
end

def get_character_movies_from_api(character)
  url_list = get_array_of_movies(character)
  movie_list(url_list)
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |v, i|
    puts "#{i + 1}. #{v}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

# methods for finding movie information

def get_movie_hash
  all_movies = RestClient.get('http://www.swapi.co/api/films/')
  hash = JSON.parse(all_movies)
  result = {}
    hash["results"].each do |movie|
      result[movie["title"]] = movie
    end
  result
end

def print_info(movie)
  puts "Title: #{movie["title"]}"
  puts "Episode Number: #{movie["episode_id"]}"
  puts "Release: #{movie["release_date"]}"
  puts "Description: #{movie["opening_crawl"]}"
end

def get_movie_info(movie)
  movies = get_movie_hash
  print_info(movies[movie])
end

# puts get_character_hash
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
