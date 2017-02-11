class EndangeredAnimals::Animal
  attr_accessor :name, :scientific_name, :status, :url, :population, :habitat, :place, :description

  @@all = []

  ##############################################################################################################
  # Description: Initializes an animal object with a name, scientific name, status, and url and adds to @@all  #
  # Input: <name / scientific_name / status / url, string>                                                     #
  ##############################################################################################################
  def initialize(name = nil, scientific_name = nil, status = nil, url = nil)
    @name = name
    @scientific_name = scientific_name
    @status = status
    @url = url

    @@all << self
  end

  ####################################################################
  # Description: Returns the @@all class variable of animal objects  #
  ####################################################################
  def self.all
    @@all
  end

  ####################################################################
  # Description: Resets the @@all class variable to an empty array   #
  ####################################################################
  def self.reset
    @@all = []
  end

  #########################################################################################################
  # Description: Takes index number based on the input and returns the animal object based on that index  #
  # Input: <index, int> The index based on user input that has been converted to int                      #
  #########################################################################################################
  def self.get_animal_from_index(index)
    @@all[index]
  end
end
