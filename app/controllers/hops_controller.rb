class HopsController < ApplicationController

  def index
    @hops = Hop.all
    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @hop }
    end

  end

  def show
    @hop = Hop.find(params[:id])
  end


  def new
    @hop = Hop.new
    respond_to do |format|
      format.html
      format.xml { render :xml => @hop }
    end
  end


  def edit
    @hop = Hop.find(params[:id])
  end


  def create
    @hop = Hop.new(params[:hop])

    respond_to do |format|
      if @hop.save
        flash[:notice] = 'Hop was successfully created.'
        format.html { redirect_to(@hop) }
        format.xml { render :xml => @hop , :status => :created, :location => @beer_style }
      else
        format.html { render :action => "new" }
        format.xml {render :xml => @hop.errors, :status => :unprocessable_entity}
      end
    end
  end


  def update
    @hop = Hop.find(params[:id])

    respond_to do |format|
      if @hop.update_attributes(params[:hop])
        flash[:notice] = 'Hop was successfully updated.'
        format.html { redirect_to(@hop) }
        format.xml  { head :ok }
      else
        format.html {render :action => "edit" }
        format.xml {render :xml => @hop.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @hop = Hop.find(params[:id])
    @hop.destroy

    respond_to do |format|
      format.html { redirect_to(hops_url) }
      format.xml { head :ok }
    end
  end

end
