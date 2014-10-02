class BeerStylesController < ApplicationController
  before_filter :find_beer_style,
    :only => [:show, :edit, :update, :destroy]

  # GET /beer_styles
  def index
    @beer_styles = BeerStyle.order :name
  end

  # GET /beer_styles/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @beer_style }
    end
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
    @beer_style = BeerStyle.new beer_style_params

    if @beer_style.save
      flash[:notice] = 'BeerStyle was successfully created.'
      redirect_to @beer_style
    else
      render :new
    end
  end

  # PUT /beer_styles/1
  def update
    authorize! :update, @beer_style

    if @beer_style.update beer_style_params
      flash[:notice] = 'BeerStyle was successfully updated.'
      redirect_to @beer_style
    else
      render :edit
    end
  end

  # DELETE /beer_styles/1
  def destroy
    authorize! :destroy, @beer_style

    @beer_style.destroy
    redirect_to beer_styles_path
  end

  private

  def find_beer_style
      @beer_style = BeerStyle.find(params[:id])
  end

  def beer_style_params
    @beer_style_params ||= params.require(:beer_style).permit(
      :name, :category, :lager, :description,
      :min_orig_grav, :max_orig_grav, :min_final_grav, :max_final_grav,
      :min_IBUs, :max_IBUs, :min_color, :max_color,
      :min_carbonation, :max_carbonation, :min_abv, :max_abv)
  end

end

