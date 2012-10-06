class HopAdditionsController < ApplicationController

  def show
    @hop_addition = HopAddition.find(params[:id])
  end

  def index
    @recipe = Recipe.find(params[:recipe_id])
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @hop_addition = HopAddition.new
    @remote = request.xhr?
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.add_hop(
      params[:hop_addition],
      success: method(:created_successfully),
      failure: method(:creation_failed))
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
    @recipe = @hop_addition.recipe

    respond_to do |format|
      format.html do
        flash[:notice] = "Removed hop addition for " + @hop_addition.hop.name
        redirect_to(edit_recipe_path(@hop_addition.recipe_id))
      end
      format.js {}
    end
  end

  private
  def created_successfully( hop_addition )
    respond_to do |format|
      format.html do
        redirect_to edit_recipe_path(@recipe),
          :notice => "Added #{hop_addition.hop.name} to recipe"
      end

      format.js {}
    end
  end

  def creation_failed( hop_addition )
    @hop_addition = hop_addition

    respond_to do |format|
      format.html { render :new }

      format.js do
        @remote = true
        render :new
      end
    end
  end

end

