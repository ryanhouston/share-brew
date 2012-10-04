class FermentableAdditionsController < ApplicationController

  def index
    @recipe = Recipe.find(params[:recipe_id])
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @fermentable_addition = @recipe.fermentable_additions.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @fermentable_addition = @recipe.fermentable_additions.build(params[:fermentable_addition])

    if @fermentable_addition.save
      flash[:notice] = "Added #{@fermentable_addition.fermentable.name} to recipe"
      redirect_to edit_recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @fermentable_addition = FermentableAddition.find(params[:id])
  end

  def update
    @fermentable_addition = FermentableAddition.find(params[:id])

    if @fermentable_addition.update_attributes(params[:fermentable_addition])
      redirect_to edit_recipe_path(@fermentable_addition.recipe)
    else
      render :edit
    end
  end
end
