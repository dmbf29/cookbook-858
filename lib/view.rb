class View
  def display(recipes)
    puts '*' * 30
    puts "Here are your recipes:"
    recipes.each_with_index do |recipe, index|
      x_mark = recipe.done? ? "X" : " "
      puts "#{index + 1}. [#{x_mark}] #{recipe.name} - #{recipe.description} (#{recipe.rating}/5) - Prep: #{recipe.prep_time}"
    end
    puts '*' * 30
  end

  def ask_for(thing)
    print "What's the #{thing} of your recipe?\n> "
    gets.chomp
  end

  def ask_for_index
    print "What's the number of your recipe?\n> "
    gets.chomp.to_i - 1
  end
end
