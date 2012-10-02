class RecipesController < ApplicationController
  before_filter :find_recipe,
    :only => [:show, :edit, :update, :destroy]

  before_filter :require_authentication,
    :only => [:edit, :update, :create, :new]

  private
    def find_recipe
      @recipe = Recipe.find(params[:id])
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
    @recipe.user_id = current_user.id
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  def create
    @beer_style = BeerStyle.find(params[:recipe][:beer_style]);
    params[:recipe][:beer_style] = @beer_style;
    @recipe = Recipe.new(params[:recipe])

    if @recipe.save
      redirect_to(edit_recipe_path(@recipe), :notice => 'Recipe was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /recipes/1
  def update
    @recipe = Recipe.find(params[:id])
    params[:recipe][:beer_style] = BeerStyle.find(params[:recipe][:beer_style]);

    if @recipe.update_attributes(params[:recipe])
      redirect_to(@recipe, :notice => 'Recipe was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to(recipes_url)
  end
end
