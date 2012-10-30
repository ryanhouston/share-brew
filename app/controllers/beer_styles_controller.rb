class BeerStylesController < ApplicationController
  before_filter :find_beer_style,
    :only => [:show, :edit, :update, :destroy]

  private

    def find_beer_style
        @beer_style = BeerStyle.find(params[:id])
    end

  public

  # GET /beer_styles
  def index
    @beer_styles = BeerStyle.order :name
  end

  # GET /beer_styles/1
  def show
  end

  # GET /beer_styles/new
  def new
    authorize! :create, BeerStyle
    @beer_style = BeerStyle.new
  end

  # GET /beer_styles/1/edit
  def edit
    authorize! :update, @beer_style
  end

  # POST /beer_styles
  def create
    authorize! :create, BeerStyle
    @beer_style = BeerStyle.new(params[:beer_style])

    if @beer_style.save
      flash[:notice] = 'BeerStyle was successfully created.'
      redirect_to(@beer_style)
    else
      render :action => "new"
    end
  end

  # PUT /beer_styles/1
  def update
    authorize! :update, @beer_style

    if @beer_style.update_attributes(params[:beer_style])
      flash[:notice] = 'BeerStyle was successfully updated.'
      redirect_to(@beer_style)
    else
      render :action => "edit"
    end
  end

  # DELETE /beer_styles/1
  def destroy
    authorize! :destroy, @beer_style

    @beer_style.destroy
    redirect_to(beer_styles_url)
  end
end
