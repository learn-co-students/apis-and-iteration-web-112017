def welcome
  puts "Welcome to the Star Wars Character Info App"
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  user_input = gets.chomp.downcase
  #return user_input.downcase
end
