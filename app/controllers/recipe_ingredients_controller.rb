class RecipeIngredientsController < ApplicationController
  # GET /recipes/1/recipe_ingredients
  # GET /recipes/1/recipe_ingredients.xml
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredients = RecipeIngredient.find_all_by_recipe_id(params[:recipe_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipe_ingredients }
    end
  end

  # GET /recipes/1/recipe_ingredients/1
  # GET /recipes/1/recipe_ingredients/1.xml
  def show
    @recipe_ingredient = RecipeIngredient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe_ingredient }
    end
  end

  # GET /recipes/1/recipe_ingredients/new
  # GET /recipes/1/recipe_ingredients/new.xml
  def new
    @recipe = Recipe.find(params[:recipe_id]);
    @recipe_ingredient = RecipeIngredient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recipe_ingredient }
    end
  end

  # GET /recipes/1/recipe_ingredients/1/edit
  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  # POST /recipes/1/recipe_ingredients
  # POST /recipes/1/recipe_ingredients.xml
  def create
    recipe = Recipe.find(params[:recipe_id])
    ingredient = Ingredient.find(params[:recipe_ingredient][:ingredient])
    params[:recipe_ingredient][:ingredient] = ingredient
    params[:recipe_ingredient][:recipe] = recipe
    @recipe_ingredient = RecipeIngredient.new(params[:recipe_ingredient])

    respond_to do |format|
      if @recipe_ingredient.save
        format.html { redirect_to([recipe, @recipe_ingredient], :notice => 'RecipeIngredient was successfully created.') }
        format.xml  { render :xml => @recipe_ingredient, :status => :created, :location => @recipe_ingredient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1/recipe_ingredients/1
  # PUT /recipes/1/recipe_ingredients/1.xml
  def update
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    params[:recipe_ingredient][:recipe] = Recipe.find(params[:recipe_id])
    params[:recipe_ingredient][:ingredient] = Ingredient.find(params[:recipe_ingredient][:ingredient])

    respond_to do |format|
      if @recipe_ingredient.update_attributes(params[:recipe_ingredient])
        format.html { redirect_to([@recipe_ingredient.recipe, @recipe_ingredient], :notice => 'RecipeIngredient was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1/recipe_ingredients/1
  # DELETE /recipes/1recipe_ingredients/1.xml
  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    recipe = @recipe_ingredient.recipe
    @recipe_ingredient.destroy

    respond_to do |format|
      format.html { redirect_to(recipe_recipe_ingredients_url(recipe)) }
      format.xml  { head :ok }
    end
  end
end
