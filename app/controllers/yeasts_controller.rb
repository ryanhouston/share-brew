class YeastsController < ApplicationController
  before_filter :find_yeast, only: [:edit, :update, :destroy, :show]

  # GET /yeasts
  def index
    @yeasts = Yeast.order :strain
  end

  # GET /yeasts/1
  def show
  end

  # GET /yeasts/new
  def new
    authorize! :create, Yeast
    @yeast = Yeast.new
  end

  # GET /yeasts/1/edit
  def edit
    authorize! :update, @yeast
  end

  # POST /yeasts
  def create
    authorize! :create, Yeast
    @yeast = Yeast.new(yeast_params)

    if @yeast.save
      redirect_to(@yeast, :notice => 'Yeast was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /yeasts/1
  def update
    authorize! :update, @yeast

    if @yeast.update_attributes(yeast_params)
      redirect_to(@yeast, :notice => 'Yeast was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /yeasts/1
  def destroy
    authorize! :destroy, @yeast
    @yeast.destroy

    redirect_to(yeasts_url)
  end

private

  def find_yeast
    @yeast = Yeast.find(params.require(:id))
  end

  def yeast_params
    @yeast_params ||= params.require(:yeast).permit(
      :strain, :strain_type, :vendor, :form, :description,
      :min_temp, :max_temp, :catalog_id, :attenuation)
  end

end
