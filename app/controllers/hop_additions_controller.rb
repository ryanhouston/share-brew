class HopAdditionsController < ApplicationController

  def show
    @hop_addition = HopAddition.find(params.require(:id))
  end

  def index
    @recipe = Recipe.find(params.require(:recipe_id))
  end

  def new
    @recipe = Recipe.find(params.require(:recipe_id))
    @hop_addition = HopAddition.new
    @remote = request.xhr?
  end

  def create
    @recipe = Recipe.find(params.require(:recipe_id))
    @recipe.add_hop(
      hop_addition_params,
      success: method(:created_successfully),
      failure: method(:creation_failed))
  end

  def edit
    @recipe = Recipe.find(params.require(:recipe_id))
    @hop_addition = HopAddition.find(params.require(:id))

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
    @hop_addition = HopAddition.find(params.require(:id))
    @hop_addition.update_with_callbacks(
      hop_addition_params,
      success: method(:successfully_updated),
      failure: method(:failed_update))
  end

  def destroy
    @hop_addition = HopAddition.find(params.require(:id))
    @hop_addition.destroy
    @recipe = @hop_addition.recipe

    respond_to do |format|
      format.html do
        flash[:notice] = "Removed hop addition for " + @hop_addition.hop.name
        redirect_to(edit_recipe_path(@hop_addition.recipe_id))
      end
      format.js { render :update_list }
    end
  end

  private

  def hop_addition_params
    @hop_addition_params ||= params.require(:hop_addition).permit(
      :hop_id, :recipe_id, :alpha_acid, :beta_acid,
      :form, :duration, :weight, :use)
  end

  def created_successfully( hop_addition )
    respond_to do |format|
      format.html do
        redirect_to edit_recipe_path(@recipe),
          notice: "Added #{hop_addition.hop.name} to recipe"
      end

      format.js { render :update_list }
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

  def successfully_updated( hop_addition )
    respond_to do |format|
      format.html { redirect_to edit_recipe_path(@hop_addition.recipe) }
      format.js   do
        @recipe = Recipe.find(params.require(:recipe_id))
        render :update_list
      end
    end
  end

  def failed_update( hop_addition )
    respond_to do |format|
      format.html { render :edit }
      format.js   do
        @remote = true
        render :new
      end
    end
  end
end

