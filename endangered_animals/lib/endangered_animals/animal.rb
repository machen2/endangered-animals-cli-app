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

  def self.create_from_index_page(input)
    doc = Nokogiri::HTML(open("https://www.worldwildlife.org/species/directory?direction=desc&sort=extinction_status"))
    @@all = []

    doc.xpath("//tbody/tr").each do |x|
      name = x.css("td")[0].text
      scientific_name = x.css("td")[1].text
      status = x.css("td")[2].text
      url = "https://www.worldwildlife.org" + x.css("td a").attribute("href").text

      if input == status
        self.new(name, scientific_name, status, url)
      end
    end
    @@all
  end

  def self.get_animal_information(input)
    self.new("Amur Leopard", "Scientific Name", "Critcally Endangered", "https://www.worldwildlife.org/species/amur-leopard")
    index = input.to_i - 1
    animal_url = @@all[index].url

    doc = Nokogiri::HTML(open(animal_url))

    @@all[index].description = doc.css("div.span4.gutter-top-in-4.gutter-bottom-in-2.gutter-horiz-in div p").text.strip

    if doc.css("div.span2 ul li:nth-child(2) strong.hdr").text.strip.downcase == "population"
      @@all[index].population = doc.css("li:nth-child(2) div.container").text.strip
    else
      @@all[index].population = "Unlisted"
    end

    return @@all[index]
  end
end
