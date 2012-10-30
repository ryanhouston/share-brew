class YeastsController < ApplicationController
  # GET /yeasts
  def index
    @yeasts = Yeast.order :strain
  end

  # GET /yeasts/1
  def show
    @yeast = Yeast.find(params[:id])
  end

  # GET /yeasts/new
  def new
    @yeast = Yeast.new
  end

  # GET /yeasts/1/edit
  def edit
    @yeast = Yeast.find(params[:id])
  end

  # POST /yeasts
  def create
    @yeast = Yeast.new(params[:yeast])

    if @yeast.save
      redirect_to(@yeast, :notice => 'Yeast was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /yeasts/1
  def update
    @yeast = Yeast.find(params[:id])

    if @yeast.update_attributes(params[:yeast])
      redirect_to(@yeast, :notice => 'Yeast was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /yeasts/1
  def destroy
    @yeast = Yeast.find(params[:id])
    @yeast.destroy

    redirect_to(yeasts_url)
  end
end
