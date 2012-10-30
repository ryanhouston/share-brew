class FermentablesController < ApplicationController
  before_filter :find_fermentable,
    only: [:show, :edit, :update, :destroy]

private
  def find_fermentable
    @fermentable = Fermentable.find(params[:id])
  end

public
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
    @fermentable = Fermentable.new(params[:fermentable])

    if @fermentable.save
      redirect_to(@fermentable, :notice => 'Fermentable was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /fermentables/1
  def update
    authorize! :update, @fermentable

    if @fermentable.update_attributes(params[:fermentable])
      redirect_to(@fermentable, :notice => 'Fermentable was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /fermentables/1
  def destroy
    authorize! :destroy, @fermentable
    @fermentable.destroy

    redirect_to(fermentables_url)
  end
end
