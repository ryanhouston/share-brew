class YeastAdditionsController < ApplicationController

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @yeast_addition = @recipe.yeast_additions.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @yeast_addition = @recipe.yeast_additions.build(params[:yeast_addition])

    if @yeast_addition.save
      redirect_to(@recipe, :notice => "Yeast addition added")
    else
      render :new
    end
  end

end

