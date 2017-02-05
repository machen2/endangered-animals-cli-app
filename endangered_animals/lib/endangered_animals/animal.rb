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
    #should return instances of animals
    @@all
  end


end
