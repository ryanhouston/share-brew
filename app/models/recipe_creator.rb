class RecipeCreator
  def initialize( listener )
    @listener = listener
  end

  def create_for( user, params )
    recipe = Recipe.new(params)
    recipe.user = user

    if recipe.save
      @listener.create_recipe_succeeded(recipe)
    else
      @listener.create_recipe_failed(recipe)
    end
  end
end

