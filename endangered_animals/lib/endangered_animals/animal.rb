class EndangeredAnimals::Animal
  attr_accessor :name, :scientific_name, :status, :url, :population, :habitat, :description

  @@all = []

  def initialize(name = nil, scientific_name = nil, status = nil, url = nil)
    @name = name
    @scientific_name = scientific_name
    @status = status
    @url = url

    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset
    @@all = []
  end

  def self.get_animal_from_index(index)
    @@all[index]
  end
end
