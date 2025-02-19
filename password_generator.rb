CHARACTERS = Array('A'..'Z') + Array('a'..'z') + Array(0..9) + ['!', '@', '#', '$', '%', '^', '&', '*']

def generate_password(length)
  if length > 0
    Array.new(length) {CHARACTERS.sample}.join
  else
    puts "Length can't be negative."
  end
end

loop do
  puts "Type the length of the password you want to generate or 'exit':"
  length = gets.chomp
  if length.downcase == "exit"
    break
  else
    puts generate_password(length.to_i) 
  end
   
end