require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  correct_char = find_character(character_hash, character)
  find_character_films(correct_char) if correct_char
end

def find_character(character_hash, character)
  character_hash["results"].find do |person|
    person["name"].downcase == character
  end
end

def find_character_films(film_hash)
  film_hash["films"].map do |film|
    JSON.parse(RestClient.get(film))
  end
end

def parse_character_movies(films_hash)
  films_hash.each {|film| print_movie_info(film)}
end

def print_movie_info(film)
  puts "*" * 30
  puts "Episode #{film["episode_id"]}: #{film["title"]}"
  puts "Directed by: #{film["director"]}"
  puts "#{film["opening_crawl"][0..200]}..."
end

def get_movie_info_from_api(movie)
  all_films = RestClient.get('http://www.swapi.co/api/films/')
  film_hash = JSON.parse(all_films)

  find_film(film_hash, movie)
end

def find_film(film_hash, movie)
  film_hash["results"].find do |film|
    film["title"].downcase == movie
  end
end

def show_input_info(input)
  films_hash = get_character_movies_from_api(input)
  movie_info = get_movie_info_from_api(input)

  if films_hash
    parse_character_movies(films_hash)
  elsif movie_info
    print_movie_info(movie_info)
  else
    puts "Invalid input."
  end

end
