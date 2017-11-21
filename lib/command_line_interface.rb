def welcome
  "Welcome to the Star Wars movie finder!"
end

def get_input_from_user
  puts "Please enter a character or film:"
  gets.chomp.downcase
end
