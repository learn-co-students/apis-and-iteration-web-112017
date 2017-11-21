require 'rest-client'
require 'json'
require 'pry'
#
def test_if_character_exists(character,character_hash)
  test = (character_hash["results"].find {|person|
      person["name"].downcase == character})
  if test
    return true
  else
    return false
  end
end

def gets_films_urls (character_hash, character)
  films_url = (character_hash["results"].find {|person|
      person["name"].downcase == character})["films"]

end

def make_film_hash (films_url)
  films_hash = films_url.collect do |url|
    movie_hash = RestClient.get(url)
    parsed_hash = JSON.parse(movie_hash)
  end
end

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  if test_if_character_exists(character,character_hash)
    films_url = gets_films_urls(character_hash, character)
    make_film_hash(films_url)
  else
    return false
  end
end


def parse_character_movies(films_hash)
  films_hash.each_with_index do |film,i|
    puts "#{i+1} #{film["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if !films_hash
    puts "That character does not exist"
  else
    parse_character_movies(films_hash)
  end
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
