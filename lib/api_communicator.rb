require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get("http://www.swapi.co/api/people/")
  character_hash = JSON.parse(all_characters)

  films = nil
  character_hash['results'].each do |person|
    if person['name'] == character
      films = person['films']
      break
    end
  end

if films
  movies = films.map do |film|
    result = RestClient.get(film)
    movie_hash = JSON.parse(result)
    movie_hash
  end
  puts character + " appears in: "
  return movies
else
  puts "Sorry no information found for #{character}"
end


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts "Movie: " + film['title']
    puts "Episode: " + film['episode_id'].to_s
    puts "Release Date: " + film['release_date']
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
