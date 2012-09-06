class RecipeIngredientsController < ApplicationController
  # GET /recipes/1/recipe_ingredients
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredients = RecipeIngredient.find_all_by_recipe_id(params[:recipe_id])
  end

  # GET /recipes/1/recipe_ingredients/1
  def show
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  # GET /recipes/1/recipe_ingredients/new
  def new
    @recipe = Recipe.find(params[:recipe_id]);
    @recipe_ingredient = RecipeIngredient.new
  end

  # GET /recipes/1/recipe_ingredients/1/edit
  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  # POST /recipes/1/recipe_ingredients
  def create
    recipe = Recipe.find(params[:recipe_id])
    ingredient = Ingredient.find(params[:recipe_ingredient][:ingredient])
    params[:recipe_ingredient][:ingredient] = ingredient
    params[:recipe_ingredient][:recipe] = recipe
    @recipe_ingredient = RecipeIngredient.new(params[:recipe_ingredient])

    if @recipe_ingredient.save
      redirect_to([recipe, @recipe_ingredient], :notice => 'RecipeIngredient was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /recipes/1/recipe_ingredients/1
  def update
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    params[:recipe_ingredient][:recipe] = Recipe.find(params[:recipe_id])
    params[:recipe_ingredient][:ingredient] = Ingredient.find(params[:recipe_ingredient][:ingredient])

    if @recipe_ingredient.update_attributes(params[:recipe_ingredient])
      redirect_to([@recipe_ingredient.recipe, @recipe_ingredient], :notice => 'RecipeIngredient was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /recipes/1/recipe_ingredients/1
  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    recipe = @recipe_ingredient.recipe
    @recipe_ingredient.destroy

    redirect_to(recipe_recipe_ingredients_url(recipe))
  end
end
