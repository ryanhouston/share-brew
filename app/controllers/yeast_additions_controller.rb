class YeastAdditionsController < ApplicationController

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @yeast_addition = @recipe.yeast_additions.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @yeast_addition = @recipe.yeast_additions.build(params[:yeast_addition])

    if @yeast_addition.save
      redirect_to(edit_recipe_path(@recipe), :notice => "Yeast addition added")
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @yeast_addition = YeastAddition.find(params[:id])

    render :new
  end

  def update
    @yeast_addition = YeastAddition.find(params[:id])

    if @yeast_addition.update_attributes(params[:yeast_addition])
      flash[:notice] = "#{@yeast_addition.yeast.strain} yeast addition updated"
      redirect_to(edit_recipe_path(@yeast_addition.recipe_id))
    else
      render :new
    end
  end

  def destroy
    @yeast_addition = YeastAddition.find(params[:id])
    @yeast_addition.destroy
    flash[:notice] = "Removed yeast addition for " + @yeast_addition.yeast.strain
    redirect_to(edit_recipe_path(@yeast_addition.recipe_id))
  end

end

