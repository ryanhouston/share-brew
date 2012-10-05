class YeastAdditionsController < ApplicationController

  def index
    @recipe = Recipe.find(params[:recipe_id])
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @yeast_addition = @recipe.yeast_additions.build
    @remote = request.xhr?
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.add_yeast(
      params[:yeast_addition],
      success: method(:created_successfully),
      failure: method(:creation_failed))
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

  private
  def created_successfully( yeast_addition )
    respond_to do |format|
      format.html do
        redirect_to edit_recipe_path(@recipe), :notice => "Yeast addition added"
      end
      format.js {}
    end
  end

  def creation_failed( yeast_addition )
    @yeast_addition = yeast_addition

    respond_to do |format|
      format.html { render :new }

      format.js do
        @remote = true
        render :new
      end
    end
  end
end

