#CLI Controller, welcomes user, deals with input
class EndangeredAnimals::CLI

  def call
    welcome
    call_start
    goodbye
  end

  def welcome
    puts "", "Welcome to the Endangered Animals CLI!"
  end

  def call_start
    restart = true
    while restart
      restart = start
    end
  end

  def start
    puts "", "Enter the number of the conservation status you would like to see or type exit:"
    puts "1. Critically Endangered", "2. Endangered", "3. Vulnerable"
    print "> "

    input = gets.strip.downcase

    input = verification_one(input)

    if input == false
      return false
    end

    print_animal_list(input)

    puts "", "Which animal would you like to get more information on? Please type the number or exit."
    print "> "
    input = gets.strip.downcase

    input = verification_two(input)

    if input == false
      return false
    end

    get_animal_description(input)

    puts "", "Would you like to see another animal? Please enter Y or N."
    print "> "

    input = nil
    input = gets.strip.downcase

    return verification_three(input)
  end

######### PRINTING METHODS #########
  def print_animal_list(input)
    puts "", "Listing the animals under the #{input} conservation status."
    puts "", "      Animal Name                  Scientific Name               "
    puts "-------------------------------------------------------------------"
    animals = EndangeredAnimals::Animal.create_from_index_page(input)
    animals.each.with_index(1) do |animal, index|
      puts "#{index.to_s.rjust(2)}#{".".ljust(3)} #{animal.name.ljust(28)} #{animal.scientific_name.ljust(30)}"
    end
  end

  def get_animal_description(input)
    animal = EndangeredAnimals::Animal.get_animal_information(input)

    puts "", "                 ~* #{animal.name} *~"
    puts "-------------------------------------------------------------------"
    puts "Scientific Name:          #{animal.scientific_name}"
    puts "Status:                   #{animal.status}"
    puts "Population:               #{animal.population}"
    puts "Habitat:                  #{animal.habitat}"
    puts "-----------------"
    puts "| Description:  |"
    puts "-----------------", "#{animal.description}"
  end

######### INPUT VERIFICATION METHODS #########
  def verification_one(input)
    while input != "1" && input != "2" && input != "3"
      if input == "exit"
        return false
      else
        puts "Please enter (1-3) or type exit."
        print "> "
        input = gets.strip.downcase
      end
    end

    case input
    when "1"
      input = "Critically Endangered"
    when "2"
      input = "Endangered"
    when "3"
      input = "Vulnerable"
    end
    input
  end

  def verification_two(input)
    if input == "exit"
      return false
    end

    while input.to_i <= 0 || input.to_i > (EndangeredAnimals::Animal.all.length)
      puts "Please enter a number between 1 and #{EndangeredAnimals::Animal.all.length}."
      input = gets.strip
    end
    input
  end

  def verification_three(input)
    while input != "n"
      if input == "y"
        return true
      else
        puts "Please enter Y to see another animal or N to exit."
        print "> "
        input = gets.strip.downcase
      end
    end
    return false
  end
######## CLOSING METHOD #########
  def goodbye
    puts "", "Thank you! Goodbye :)"
  end
end
