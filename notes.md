input = nil
while input != "exit"
  input = gets.strip.downcase

  case input
  when "1"
    puts "scraping..listing critically endangered animals"
  when "2"
    puts "scraping..listing endangered animals"
  when "3"
    puts "scraping..listing vulnerable animals"
  when "exit"
    return
  else
    puts "Please enter a number (1-3) or type exit."
  end
end
end
