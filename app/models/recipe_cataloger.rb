class RecipeCataloger
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

  def update_with( recipe, params )
    if recipe.update_attributes(params)
      @listener.update_recipe_succeeded(recipe)
    else
      @listener.update_recipe_failed(recipe)
    end
  end
end

