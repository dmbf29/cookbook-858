class Recipe
  attr_reader :name, :description, :rating, :prep_time

  # def initialize(name, description, rating)
  def initialize(attributes = {})
    @name = attributes[:name] # string
    @description = attributes[:description] # string
    @rating = attributes[:rating] # string
    @prep_time = attributes[:prep_time] # string
    @done = attributes[:done] || false # boolean
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = !@done
  end
end

# Recipe.new('pizza', 'dough with sauce and cheese', 3, false, '10min')
# p Recipe.new
# Recipe.new(
#   name: 'Pizza',
#   description: 'dough with sauce and cheese',
#   rating: 5
# )
