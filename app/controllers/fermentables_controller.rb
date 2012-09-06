class FermentablesController < ApplicationController
  # GET /fermentables
  def index
    @fermentables = Fermentable.all
  end

  # GET /fermentables/1
  def show
    @fermentable = Fermentable.find(params[:id])
  end

  # GET /fermentables/new
  def new
    @fermentable = Fermentable.new
  end

  # GET /fermentables/1/edit
  def edit
    @fermentable = Fermentable.find(params[:id])
  end

  # POST /fermentables
  def create
    @fermentable = Fermentable.new(params[:fermentable])

    if @fermentable.save
      redirect_to(@fermentable, :notice => 'Fermentable was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /fermentables/1
  def update
    @fermentable = Fermentable.find(params[:id])

    if @fermentable.update_attributes(params[:fermentable])
      redirect_to(@fermentable, :notice => 'Fermentable was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /fermentables/1
  def destroy
    @fermentable = Fermentable.find(params[:id])
    @fermentable.destroy

    redirect_to(fermentables_url)
  end
end
