class YeastAdditionsController < ApplicationController

  def index
    @recipe = Recipe.find(params.require(:recipe_id))
  end

  def new
    @recipe = Recipe.find(params.require(:recipe_id))
    @yeast_addition = @recipe.yeast_additions.build
    @remote = request.xhr?
  end

  def create
    @recipe = Recipe.find(params.require(:recipe_id))
    @recipe.add_yeast(
      yeast_addition_params,
      success: method(:created_successfully),
      failure: method(:creation_failed))
  end

  def edit
    @recipe = Recipe.find(params.require(:recipe_id))
    @yeast_addition = YeastAddition.find(params.require(:id))

    respond_to do |format|
      format.js { @remote = true }
    end

    render :new
  end

  def update
    @recipe = Recipe.find(params.require(:recipe_id))
    @yeast_addition = YeastAddition.find(params.require(:id))
    @yeast_addition.update_with_callbacks(
      yeast_addition_params,
      success: method(:successfully_updated),
      failure: method(:failed_update))
  end

  def destroy
    @yeast_addition = YeastAddition.find(params.require(:id))
    @yeast_addition.destroy
    @recipe = Recipe.find(params.require(:recipe_id))

    respond_to do |format|
      format.html do
        flash[:notice] = "Removed yeast addition for " + @yeast_addition.yeast.strain
        redirect_to(edit_recipe_path(@yeast_addition.recipe_id))
      end
      format.js { render :update_list }
    end
  end

private

  def yeast_addition_params
    @yeast_addition_params ||= params.require(:yeast_addition).permit(
      :recipe_id, :yeast_id, :starter_size, :use_starter)
  end

  def created_successfully( yeast_addition )
    respond_to do |format|
      format.html do
        redirect_to edit_recipe_path(@recipe), notice: "Yeast addition added"
      end
      format.js { render :update_list }
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

  def successfully_updated( yeast_addition )
    respond_to do |format|
      format.html { redirect_to edit_recipe_path(@recipe) }
      format.js { render :update_list }
    end
  end

  def failed_update( yeast_addition )
    respond_to do |format|
      format.html { render :edit }
      format.js   do
        @remote = true
        render :new
      end
    end
  end
end

