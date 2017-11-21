require 'rest-client'
require 'json'
require 'pry'

def formatted_api_hashes(result)

all_characters = RestClient.get('http://www.swapi.co/api/people/')
character_hash = JSON.parse(all_characters)

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  requested_hash = character_hash["results"].find do |character_element_hash|
    character_element_hash["name"] == character
  end
  requested_hash["films"].map do |film_url|
    JSON.parse(RestClient.get(film_url))
  end
end

def parse_character_movies(films_hash)
  films_hash.each do |film_element_hash|
    puts film_element_hash["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

show_character_movies("Luke Skywalker")


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

def random_facts()
