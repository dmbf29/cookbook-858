require 'nokogiri'
require 'open-uri'

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # usen the HMTL file until after you get to prep_time
    html = File.open('lib/chocolate.html')
    # give the html to Nokogiri
    doc = Nokogiri::HTML(html, nil, "utf-8")
    # we need to search for the stuff we need (name and description)
    doc.search('.card__detailsContainer').each do |card_element|
      # find the name
      p name = card_element.search('.card__title')
      # find description
      # create instance
    end
    # should return an array of the first 5 recipes
  end

  # nokigiri search methods
  # doc.search('#id')
  # doc.search('.class')
  # doc.search('.parent .class')
  # doc.search('h3')
end

# We'll call this service object in the controller
# recipes = ScrapeAllrecipesService.new('chocolate').call
# should return => an array of INSTANCES
