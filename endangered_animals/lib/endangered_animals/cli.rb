#CLI Controller, welcomes user, deals with input
class EndangeredAnimals::CLI
  ################################################
  # Description: Calls the entire program        #
  ################################################
  def call
    welcome
    call_start
    goodbye
  end

  #######################################################
  # Description: Prints a welcome message to the user   #
  #######################################################
  def welcome
    puts "", "Welcome to the Endangered Animals CLI!"
  end

  ###################################################################################################
  # Description: Controls the main body of the CLI, will recall start method if start returns true  #
  #              or end if the start method returns false                                           #
  ###################################################################################################
  def call_start
    restart = true
    while restart
      restart = start
    end
  end

  #############################################################################################################
  # Description: In charge of the main CLI interaction with the user, prompts and receives users inputs       #
  # Output: <true or false, boolean> true if the user wants to look at another animal false if user does not  #
  #############################################################################################################
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

  ###########################################################################################
  # Description: Prints out a list of animals from WWF based on conservatin status chosen   #
  # Input: <input, string> user input converted to the appropriate conservation status      #
  # Output: Prints formatted animal list                                                    #
  ###########################################################################################
  def print_animal_list(input)
    puts "", "Listing the animals under the #{input} conservation status."
    puts "", "      Animal Name                  Scientific Name               "
    puts "-------------------------------------------------------------------"
    animals = EndangeredAnimals::Scraper.create_from_index_page(input)
    animals.each.with_index(1) do |animal, index|
      puts "#{index.to_s.rjust(2)}#{".".ljust(3)} #{animal.name.ljust(28)} #{animal.scientific_name.ljust(30)}"
    end
  end

  ############################################################################################
  # Description: Prints out the animal description based on user input                       #
  # Input: <input, string> user input                                                        #
  # Output: Prints animal description that was scraped in Scraper class                      #
  ############################################################################################
  def get_animal_description(input)
    animal = EndangeredAnimals::Scraper.get_animal_information(input)

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

  ##############################################################################################
  # Description: Validates the user input and changes input to the conservation status chosen  #
  # Input: <input, string> User Input                                                          #
  # Output: <input, string> Outputs the converted user input or false to exit program          #
  ##############################################################################################
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

  ########################################################################################
  # Description: Validates user input and returns the inout or false to exit program     #
  # Input: <input, string> User input                                                    #
  # Output: <input, string> Input if valid (or false to exit)                            #
  ########################################################################################
  def verification_two(input)
    if input == "exit"
      return false
    end

    while input.to_i <= 0 || input.to_i > (EndangeredAnimals::Animal.all.length)
      puts "Please enter a number between 1 and #{EndangeredAnimals::Animal.all.length} or type exit."
      input = gets.strip

      if input == "exit"
        return false
      end
    end
    input
  end

  ################################################################################################
  # Description: Validates user input and returns true to recall start or false to exit program  #
  # Input: <input, string> User input                                                            #
  # Output: <true/false, boolean> True or false based on user input                              #
  ################################################################################################
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

  #################################################################
  # Description: Prints a goodbye message to the user             #
  #################################################################
  def goodbye
    puts "", "Thank you! Goodbye :)"
  end
end
