class BeerStylesController < ApplicationController
  before_filter :find_beer_style,
    :only => [:show, :edit, :update, :destroy]

  private

    def find_beer_style
        @beer_style = BeerStyle.find(params[:id])
    end

  public

  # GET /beer_styles
  # GET /beer_styles.xml
  def index
    @beer_styles = BeerStyle.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @beer_styles }
    end
  end

  # GET /beer_styles/1
  # GET /beer_styles/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @beer_style }
    end
  end

  # GET /beer_styles/new
  # GET /beer_styles/new.xml
  def new
    @beer_style = BeerStyle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @beer_style }
    end
  end

  # GET /beer_styles/1/edit
  def edit
  end

  # POST /beer_styles
  # POST /beer_styles.xml
  def create
    @beer_style = BeerStyle.new(params[:beer_style])

    respond_to do |format|
      if @beer_style.save
        flash[:notice] = 'BeerStyle was successfully created.'
        format.html { redirect_to(@beer_style) }
        format.xml  { render :xml => @beer_style, :status => :created, :location => @beer_style }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @beer_style.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /beer_styles/1
  # PUT /beer_styles/1.xml
  def update
    respond_to do |format|
      if @beer_style.update_attributes(params[:beer_style])
        flash[:notice] = 'BeerStyle was successfully updated.'
        format.html { redirect_to(@beer_style) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @beer_style.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /beer_styles/1
  # DELETE /beer_styles/1.xml
  def destroy
    @beer_style.destroy

    respond_to do |format|
      format.html { redirect_to(beer_styles_url) }
      format.xml  { head :ok }
    end
  end
end
