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

  def self.create_from_index_page(input)
    doc = Nokogiri::HTML(open("https://www.worldwildlife.org/species/directory?direction=desc&sort=extinction_status"))
    @@all = []

    doc.xpath("//tbody/tr").each do |x|
      name = x.css("td")[0].text
      scientific_name = x.css("td")[1].text
      status = x.css("td")[2].text
      url = x.css("td a").attribute("href").text

      if input == status
        self.new(name, scientific_name, status, url)
      end
    end
    @@all
  end

  def self.all
    #should return instances of animals
    @@all
  end

end
