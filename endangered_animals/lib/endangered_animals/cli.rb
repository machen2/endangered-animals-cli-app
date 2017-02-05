#CLI Controller, welcomes user, deals with input
class EndangeredAnimals::CLI

  def call
    welcome
    start
    goodbye
  end

  def welcome
    puts "", "Welcome to the Endangered Animals CLI!", ""
  end

  def start
    puts "Enter the number of the conservation status you would like to see or type exit:"
    puts "1. Critically Endangered"
    puts "2. Endangered"
    puts "3. Vulnerable"

    input = gets.strip.downcase

    #ADD SOME INPUT VERIFICATION

    print_animal_list(input)

    puts ""
    puts "Which animal would you like to get more information on? Please type the number or exit."
    puts ""

    input = gets.strip.downcase

    get_animal_description(input)

    puts "", "Would you like to see another animal? Please enter Y or N."

    input = gets.strip.downcase
    while input != "n"
      if input == "y"
        start
      else
        puts "Please enter Y to see another animal or N to exit."
      end
      input = gets.strip.downcase
    end
    return
  end

  def print_animal_list(input)
    puts "getting animal list"


  end

  def get_animal_description(input)
    puts "getting animal description"
  end

  def goodbye
    puts "", "Thank you! Goodbye :)"
  end
end
