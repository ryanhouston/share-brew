class YeastsController < ApplicationController
  before_filter :find_yeast, only: [:edit, :update, :destroy, :show]
private
  def find_yeast
    @yeast = Yeast.find(params[:id])
  end

public

  # GET /yeasts
  def index
    @yeasts = Yeast.order :strain
  end

  # GET /yeasts/1
  def show
  end

  # GET /yeasts/new
  def new
    @yeast = Yeast.new
  end

  # GET /yeasts/1/edit
  def edit
    authorize! :update, @yeast
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
    authorize! :update, @yeast

    if @yeast.update_attributes(params[:yeast])
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
end
