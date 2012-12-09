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
    creator = RecipeCreator.new(self)
    creator.create_for(current_user, params[:recipe])
  end

  def create_recipe_succeeded( recipe )
    redirect_to(edit_recipe_path(recipe), :notice => 'Recipe was successfully created.')
  end

  def create_recipe_failed( recipe )
    @recipe = recipe
    render :action => "new"
  end

  # PUT /recipes/1
  def update
    authorize! :update, @recipe

    if @recipe.update_attributes(params[:recipe])
      redirect_to(@recipe, :notice => 'Recipe was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /recipes/1
  def destroy
    authorize! :destroy, @recipe
    @recipe.destroy

    redirect_to(recipes_url)
  end
end
