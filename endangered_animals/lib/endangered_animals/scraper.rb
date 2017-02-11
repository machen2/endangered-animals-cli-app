class EndangeredAnimals::Scraper

  ####################################################################################################################
  # Description: Scrapes name, scientific name, status from WWF site and makes Animal instances based on user input  #
  # Input: <input, string> user input                                                                                #
  #  Output: <EndangeredAnimals::Animal.all, array of animal objects>                                                #
  ####################################################################################################################
  def self.create_from_index_page(input)
    doc = Nokogiri::HTML(open("https://www.worldwildlife.org/species/directory?direction=desc&sort=extinction_status"))
    EndangeredAnimals::Animal.reset

    doc.xpath("//tbody/tr").each do |x|
      name = x.css("td")[0].text
      scientific_name = x.css("td")[1].text
      if scientific_name == ""
        scientific_name = "[Unlisted]"
      end
      status = x.css("td")[2].text
      url = "https://www.worldwildlife.org" + x.css("td a").attribute("href").text

      if input == status
        EndangeredAnimals::Animal.new(name, scientific_name, status, url)
      end
    end
    EndangeredAnimals::Animal.all
  end

  ##################################################################################################################
  # Description: Scrapes habitat, population, description based on user input and saves it to an Animal instance   #
  # Input: <input, string> user input                                                                              #
  # Output: <animal, EndangeredAnimals::Animal> animal instance with upsated info                                  #
  ##################################################################################################################

  def self.temp
    EndangeredAnimals::Scraper.create_from_index_page("Critically Endangered")
    EndangeredAnimals::Scraper.get_animal_information("1")
  end

  def self.get_animal_information(input)
    index = input.to_i - 1
    animal = EndangeredAnimals::Animal.get_animal_from_index(index)
    animal_url = animal.url

    doc = Nokogiri::HTML(open(animal_url))

    if doc.css("div.span6 ul.list-data.list-spaced li:nth-child(1) strong").text.strip.downcase
      if doc.css("div.span6 ul.list-data.list-spaced li:nth-child(1) strong").text.strip.downcase == "places" #|| doc.css("div.span6 ul.list-data.list-spaced li strong").text.strip.downcase == "places"
        places = []
        places << doc.css("ul.list-data.list-spaced li:nth-child(1) div.lead").text.strip
        animal.place = places.join(", ")

        habitats = []
        habitats << doc.css("ul.list-data.list-spaced li:nth-child(2) div.lead").text.strip
        animal.habitat = habitats.join(", ")

      elsif doc.css("div.span6 ul.list-data.list-spaced li:nth-child(1) strong").text.strip.downcase == "habitats"
        habitats = []
        habitats << doc.css("ul.list-data.list-spaced li:nth-child(1) div.lead").text.strip
        animal.habitat = habitats.join(", ")
      end

    elsif doc.css("div.span6 ul.list-data.list-spaced li strong").text.strip.downcase == "places"
      places = []
      places << doc.css("ul.list-data.list-spaced li div.lead").text.strip
      animal.place = places.join(", ")
      animal.habitat = "[Unlisted]"

    elsif doc.css("div.span6 ul.list-data.list-spaced li strong").text.strip.downcase == "habitat"
      habitats = []
      habitats << doc.css("ul.list-data.list-spaced li div.lead").text.strip
      animal.habitat = habitats.join(", ")
      animal.place = "[Unlisted]"
    end

    #in case neither are found
    if animal.habitat == "" || animal.habitat == nil
      animal.habitat = "[Unlisted]"
    end
    if animal.place == "" || animal.place == nil
      animal.place = "[Unlisted]"
    end

    animal.description = doc.css("div.span4.gutter-top-in-4.gutter-bottom-in-2.gutter-horiz-in div").text.strip.gsub("\n", " ")

    if doc.css("div.span2 ul li:nth-child(2) strong.hdr").text.strip.downcase == "population"
      animal.population = doc.css("li:nth-child(2) div.container").text.strip
    else
      animal.population = "[Unlisted]"
    end
    return animal
  end
end
