require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`

  # collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.
  find_character_films(find_character(character, character_hash))
end

def find_character_films(correct_character_hash)
  correct_character_hash["films"].map { |film_api|
    film_info = RestClient.get(film_api)
    film_info_json = JSON.parse(film_info)
     }
end

def find_character(character, character_hash)
  character_hash["results"].find do |array_of_hashes_with_char_info|
    array_of_hashes_with_char_info["name"].downcase == character
end

def find_film()

end

end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  #binding.pry
  films_hash.each { |f| print_movie_info(f) }
end

def print_movie_info(film)
  puts "*"*30
  puts "Episide #{film["episode_id"]}: #{film["title"]}"
  puts film["director"]
  puts film["opening_crawl"][0..200]
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
