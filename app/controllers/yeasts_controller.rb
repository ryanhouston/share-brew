class YeastsController < ApplicationController
  # GET /yeasts
  # GET /yeasts.xml
  def index
    @yeasts = Yeast.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yeasts }
    end
  end

  # GET /yeasts/1
  # GET /yeasts/1.xml
  def show
    @yeast = Yeast.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @yeast }
    end
  end

  # GET /yeasts/new
  # GET /yeasts/new.xml
  def new
    @yeast = Yeast.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @yeast }
    end
  end

  # GET /yeasts/1/edit
  def edit
    @yeast = Yeast.find(params[:id])
  end

  # POST /yeasts
  # POST /yeasts.xml
  def create
    @yeast = Yeast.new(params[:yeast])

    respond_to do |format|
      if @yeast.save
        format.html { redirect_to(@yeast, :notice => 'Yeast was successfully created.') }
        format.xml  { render :xml => @yeast, :status => :created, :location => @yeast }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @yeast.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /yeasts/1
  # PUT /yeasts/1.xml
  def update
    @yeast = Yeast.find(params[:id])

    respond_to do |format|
      if @yeast.update_attributes(params[:yeast])
        format.html { redirect_to(@yeast, :notice => 'Yeast was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @yeast.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /yeasts/1
  # DELETE /yeasts/1.xml
  def destroy
    @yeast = Yeast.find(params[:id])
    @yeast.destroy

    respond_to do |format|
      format.html { redirect_to(yeasts_url) }
      format.xml  { head :ok }
    end
  end
end
