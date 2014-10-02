class FermentablesController < ApplicationController
  before_filter :find_fermentable, only: [:show, :edit, :update, :destroy]

  # GET /fermentables
  def index
    @fermentables = Fermentable.order :name
  end

  # GET /fermentables/1
  def show
  end

  # GET /fermentables/new
  def new
    authorize! :create, Fermentable
    @fermentable = Fermentable.new
  end

  # GET /fermentables/1/edit
  def edit
    authorize! :update, @fermentable
  end

  # POST /fermentables
  def create
    authorize! :create, Fermentable
    @fermentable = Fermentable.new(fermentable_params)

    if @fermentable.save
      redirect_to(@fermentable, :notice => 'Fermentable was successfully created.')
    else
      render :new
    end
  end

  # PUT /fermentables/1
  def update
    authorize! :update, @fermentable

    if @fermentable.update(fermentable_params)
      redirect_to(@fermentable, :notice => 'Fermentable was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /fermentables/1
  def destroy
    authorize! :destroy, @fermentable
    @fermentable.destroy

    redirect_to(fermentables_url)
  end

private

  def find_fermentable
    @fermentable ||= Fermentable.find(params[:id])
  end

  def fermentable_params
    @fermentable_params ||= params.require(:fermentable).permit(
      :name, :origin, :vendor, :form, :color,
      :potential, :yield, :max_in_batch, :notes)
  end

end
