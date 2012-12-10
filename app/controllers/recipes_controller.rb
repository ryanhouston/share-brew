class RecipesController < ApplicationController
  before_filter :find_recipe,
    :only => [:show, :edit, :update, :destroy]

  before_filter :require_authentication,
    :only => [:edit, :update, :create, :new]

private
  def find_recipe
    @recipe = Recipe.find_with_ingredients params[:id]
  end

public

  # GET /recipes
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    authorize! :update, @recipe
  end

  # POST /recipes
  def create
    cataloger = RecipeCataloger.new(self)
    cataloger.create_for(current_user, params[:recipe])
  end

  def create_recipe_succeeded( recipe )
    # After create start the user on the Ingredients tab as the next step
    redirect_to(
      edit_recipe_path(recipe) + '#tab-ingredients',
      notice: 'Recipe was successfully created.')
  end

  def create_recipe_failed( recipe )
    @recipe = recipe
    render :action => "new"
  end

  # PUT /recipes/1
  def update
    authorize! :update, @recipe
    cataloger = RecipeCataloger.new(self)
    cataloger.update_with(@recipe, params[:recipe])
  end

  def update_recipe_succeeded( recipe )
    redirect_to(recipe, :notice => 'Recipe was successfully updated.')
  end

  def update_recipe_failed( recipe )
    @recipe = recipe
    render :action => "edit"
  end

  # DELETE /recipes/1
  def destroy
    authorize! :destroy, @recipe
    @recipe.destroy

    redirect_to(recipes_url)
  end
end
