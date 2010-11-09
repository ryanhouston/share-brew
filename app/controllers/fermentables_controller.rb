class FermentablesController < ApplicationController
  # GET /fermentables
  # GET /fermentables.xml
  def index
    @fermentables = Fermentable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fermentables }
    end
  end

  # GET /fermentables/1
  # GET /fermentables/1.xml
  def show
    @fermentable = Fermentable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fermentable }
    end
  end

  # GET /fermentables/new
  # GET /fermentables/new.xml
  def new
    @fermentable = Fermentable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fermentable }
    end
  end

  # GET /fermentables/1/edit
  def edit
    @fermentable = Fermentable.find(params[:id])
  end

  # POST /fermentables
  # POST /fermentables.xml
  def create
    @fermentable = Fermentable.new(params[:fermentable])

    respond_to do |format|
      if @fermentable.save
        format.html { redirect_to(@fermentable, :notice => 'Fermentable was successfully created.') }
        format.xml  { render :xml => @fermentable, :status => :created, :location => @fermentable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fermentable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fermentables/1
  # PUT /fermentables/1.xml
  def update
    @fermentable = Fermentable.find(params[:id])

    respond_to do |format|
      if @fermentable.update_attributes(params[:fermentable])
        format.html { redirect_to(@fermentable, :notice => 'Fermentable was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fermentable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fermentables/1
  # DELETE /fermentables/1.xml
  def destroy
    @fermentable = Fermentable.find(params[:id])
    @fermentable.destroy

    respond_to do |format|
      format.html { redirect_to(fermentables_url) }
      format.xml  { head :ok }
    end
  end
end
