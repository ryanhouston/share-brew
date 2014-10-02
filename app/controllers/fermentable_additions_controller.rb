class FermentableAdditionsController < ApplicationController

  def index
    @recipe = Recipe.find(params.require(:recipe_id))
  end

  def new
    @recipe = Recipe.find(params.require(:recipe_id))
    @fermentable_addition = @recipe.fermentable_additions.build
    @remote = request.xhr?
  end

  def create
    @recipe = Recipe.find(params.require(:recipe_id))
    @recipe.add_fermentable(
      fermentable_addition_params,
      success: method(:created_successfully),
      failure: method(:creation_failed)
    )
  end

  def edit
    @recipe = Recipe.find(params.require(:recipe_id))
    @fermentable_addition = FermentableAddition.find(params.require(:id))

    respond_to do |format|
      format.html { render :edit }
      format.js do
        @remote = true
        render :new
      end
    end
  end

  def update
    @recipe = Recipe.find(params.require(:recipe_id))
    @fermentable_addition = FermentableAddition.find(params.require(:id))

    @fermentable_addition.update_with_callbacks(
      fermentable_addition_params,
      success: method(:successfully_updated),
      failure: method(:failed_update))
  end

  def destroy
    @fermentable_addition = FermentableAddition.find(params.require(:id))
    @fermentable_addition.destroy
    @recipe = @fermentable_addition.recipe

    respond_to do |format|
      format.html { redirect_to edit_recipe_path(@fermentable_addition.recipe) }
      format.js { render :update_list }
    end
  end

  private

  def fermentable_addition_params
    params.require(:fermentable_addition).permit(:fermentable_id, :recipe_id, :weight)
  end

  def created_successfully( fermentable_addition )
    respond_to do |format|
      format.html do
        redirect_to edit_recipe_path(@recipe),
          notice: "Added #{fermentable_addition.fermentable.name} to recipe"
      end

      format.js { render :update_list }
    end
  end

  def creation_failed( fermentable_addition )
    @fermentable_addition = fermentable_addition

    respond_to do |format|
      format.html { render :new }

      format.js do
        @remote = true
        render :new
      end
    end
  end

  def successfully_updated( fermentable_addition )
    respond_to do |format|
      format.html { redirect_to edit_recipe_path(@recipe) }
      format.js { render :update_list }
    end
  end

  def failed_update( fermentable_addition )
    respond_to do |format|
      format.html { render :edit }
      format.js   do
        @remote = true
        render :new
      end
    end
  end

end
