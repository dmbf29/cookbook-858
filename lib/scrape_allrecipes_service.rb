require 'nokogiri'
require 'open-uri'

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # usen the HMTL file until after you get to prep_time
    # html = File.open('lib/chocolate.html')
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    html = URI.open(url).read
    # give the html to Nokogiri
    doc = Nokogiri::HTML(html, nil, "utf-8")
    # we need to search for the stuff we need (name and description)
    doc.search('.card__detailsContainer').first(5).map do |card_element|
      # find the name
      name = card_element.search('.card__title').text.strip
      # find description
      description = card_element.search('.card__summary').text.strip
      rating = card_element.search('.review-star-text').text.strip.split[1]
      recipe_url = card_element.search('.card__titleLink').attribute('href').value
      prep_time = fetch_prep_time(recipe_url)
      # create instance
      Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
    end
    # should return an array of the first 5 recipes
  end

  def fetch_prep_time(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    prep_element = doc.search('.recipe-meta-item').find do |element|
      element.text.strip.match?(/prep/i)
    end
    prep_element ? prep_element.search('.recipe-meta-item-body').text.strip : '0min'
  end
  # nokigiri search methods
  # doc.search('#id')
  # doc.search('.class')
  # doc.search('.parent .class')
  # doc.search('h3')
end

# We'll call this service object in the controller
# recipes = ScrapeAllrecipesService.new('chocolate').call
# should return => an array of RECIPES
