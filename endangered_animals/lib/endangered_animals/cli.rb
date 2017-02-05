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
    puts "1. Critically Endangered", "2. Endangered", "3. Vulnerable"
    print "> "

    input = gets.strip.downcase

    while input != "1" && input != "2" && input != "3"
      if input == "exit"
        return
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

    print_animal_list(input)

    puts "", "Which animal would you like to get more information on? Please type the number or exit."
    print "> "
    input = gets.strip.downcase

    if input == "exit"
      return
    end

    get_animal_description(input)

    puts "", "Would you like to see another animal? Please enter Y or N."
    print "> "

    input = gets.strip.downcase
    while input != "n"
      if input == "y"
        start
      else
        puts "Please enter Y to see another animal or N to exit."
        print "> "
        input = gets.strip.downcase
      end
    end
    return
  end

  def print_animal_list(input)
    puts "", "      Animal Name                  Scientific Name               "#Conservation Status"
    puts "-------------------------------------------------------------------" #{}"--------------------"
    animals = EndangeredAnimals::Animal.create_from_index_page(input)
    animals.each.with_index(1) do |animal, index|
      puts "#{index.to_s.rjust(2)}#{".".ljust(3)} #{animal.name.ljust(28)} #{animal.scientific_name.ljust(30)}" #" #{animal.status}"
    end
  end

  def get_animal_description(input)
    puts "getting animal description"
  end

  def goodbye
    puts "", "Thank you! Goodbye :)"
  end
end
