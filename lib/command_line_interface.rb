def welcome
  puts "Welcome to our Star Wars Character App"
  # puts out a welcome message here!
end

def get_character_from_user
  puts "please enter a character"
  response = gets.chomp.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
