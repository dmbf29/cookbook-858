require "csv"

class Cookbook
  def initialize(csv_filepath = nil)
    @csv_filepath = csv_filepath
    @recipes = [] # array of instances of Recipe
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    # recipe is an instance of Recipe
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    # need to get one recipe from recipes
    recipe = @recipes[index]
    # mark it as done
    recipe.mark_as_done!
    # save it
    save_csv
  end

  private

  def load_csv
    return unless @csv_filepath

    CSV.foreach(@csv_filepath, headers: :first_row, header_converters: :symbol) do |row|
      # Each row is an array of strings
      # e.g. ["Boeuf bourguignon", "Hearty red wine beef stew"]
      # p recipe = Recipe.new(name: row[:name])
      # hash[key] = new_value
      # p row
      # row[:rating] = row[:rating].to_f
      row[:done] = row[:done] == 'true'
      # p row
      recipe = Recipe.new(row)
      puts
      @recipes << recipe
    end
  end

  def save_csv
    return unless @csv_filepath

    CSV.open(@csv_filepath, "wb") do |csv|
      csv << ['name', 'description', 'rating', 'done', 'prep_time']
      @recipes.each do |recipe| # recipe is an instance of Recipe
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
