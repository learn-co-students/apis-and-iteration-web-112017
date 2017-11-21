def welcome
  # puts out a welcome message here!
  puts "Welcome to Star Wars Info!"
end

def movie_or_character
  puts "Would you like info on a movie or character?"
  input = gets.chomp
  while !["character","movie"].include?(input)
    puts "error, please indicate whether you would like info on a movie or character."
    input = gets.chomp
  end

  if input == "character"
    character = get_character_from_user
    show_character_movies(character)
  else
    movie = get_movie_from_user
    get_movie_info(movie)
  end
end

def get_character_from_user
  puts "please enter a character"
  input = gets.chomp
  character_hash = get_character_hash

  while !character_hash.keys.include?(input)
    puts "error, please enter a character"
    input = gets.chomp
  end
  input

  # use gets to capture the user's input. This method should return that input, downcased.
end

def get_movie_from_user
  puts "please enter a movie"
  input = gets.chomp
  movies = get_movie_hash

  while !movies.keys.include?(input)
    puts "error, please enter a movie"
    input = gets.chomp
  end
  input
end
