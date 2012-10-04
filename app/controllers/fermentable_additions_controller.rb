class FermentableAdditionsController < ApplicationController

  def index
    @recipe = Recipe.find(params[:recipe_id])
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @fermentable_addition = @recipe.fermentable_additions.build
    @remote = request.xhr?
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @fermentable_addition = @recipe.fermentable_additions.build(params[:fermentable_addition])

    respond_to do |format|
      if @fermentable_addition.save
        format.html do
          redirect_to edit_recipe_path(@recipe), notice:
            "Added #{@fermentable_addition.fermentable.name} to recipe"
        end
        format.js {}
      else
        format.html { render :new }
        format.js do
          @remote = true
          render :new
        end
      end
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
