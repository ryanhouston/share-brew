class HopAdditionsController < ApplicationController

  def show
    @hop_addition = HopAddition.find(params[:id])
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @hop_addition = HopAddition.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @hop_addition = @recipe.hop_additions.build(params[:hop_addition])

    if @hop_addition.save
      flash[:notice] = "Added #{@hop_addition.hop.name} to recipe"
      redirect_to edit_recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @hop_addition = HopAddition.find(params[:id])
  end

  def update
    @hop_addition = HopAddition.find(params[:id])

    if @hop_addition.update_attributes(params[:hop_addition])
      redirect_to edit_recipe_path(@hop_addition.recipe)
    else
      render :edit
    end
  end

  def destroy
    @hop_addition = HopAddition.find(params[:id])
    @hop_addition.destroy
    flash[:notice] = "Removed hop addition for " + @hop_addition.hop.name
    redirect_to(edit_recipe_path(@hop_addition.recipe_id))
  end
end

