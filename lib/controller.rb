require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Tell the view to ask for a name and description
    name = @view.ask_for('name')
    description = @view.ask_for('description')
    rating = @view.ask_for('rating')
    prep_time = @view.ask_for('prep_time')
    # Create an instance of Recipe
    recipe = Recipe.new(
      name: name,
      description: description,
      rating: rating,
      prep_time: prep_time
    )
    # Store the recipe in the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # Display the recipes
    display_recipes
    # Tell the view to ask for a recipe index
    index = @view.ask_for_index
    # Tell the cookbook to delete the recipe at that index
    @cookbook.remove_recipe(index)
  end

  def import
    # keyword = ask/get user for keyword (view's job)
    keyword = @view.ask_for('ingredient')
    # give the keyword to scraper
    recipes = ScrapeAllrecipesService.new(keyword).call
    # tell view to display the scraped recipes
    @view.display(recipes)
    # ask user which number they'd like to save
    index = @view.ask_for_index
    # get one recipe from the array using the index
    recipe = recipes[index]
    # give the recipe to the cookbook (repo)
    @cookbook.add_recipe(recipe)
  end

  def mark
    # display recipes for the user (view)
    display_recipes
    # index = ask user to choose one (view)
    index = @view.ask_for_index
    # give index to cookbook
    @cookbook.mark_as_done(index)
  end

  private

  def display_recipes
    # 1. Get all the recipes from the cookbook
    recipes = @cookbook.all
    # 2. Tell the view to display the recipes
    @view.display(recipes)
  end
end
