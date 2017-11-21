require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

    movie_hashes = character_hash["results"][0]["films"].collect do |movie|
      character_movies = RestClient.get(movie)
      JSON.parse(character_movies)
    end
end

def parse_character_movies(films_hash)
  films_hash.each do |movie|
         puts "Title: #{movie["title"]}"
         puts "Opening Crawl: #{movie["opening_crawl"][0..140]}..."
         puts "Episode Number: #{movie["episode_id"]}"
         puts "*" * 20
      end
end


def show_character_movies(character)
  dog = get_character_movies_from_api(character)
  parse_character_movies(dog)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
