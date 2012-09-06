class HopsController < ApplicationController

  def index
    @hops = Hop.all
  end

  def show
    @hop = Hop.find(params[:id])
  end


  def new
    @hop = Hop.new
  end


  def edit
    @hop = Hop.find(params[:id])
  end


  def create
    @hop = Hop.new(params[:hop])

    if @hop.save
      flash[:notice] = 'Hop was successfully created.'
      redirect_to(@hop)
    else
      render :action => "new"
    end
  end


  def update
    @hop = Hop.find(params[:id])

    if @hop.update_attributes(params[:hop])
      flash[:notice] = 'Hop was successfully updated.'
      redirect_to(@hop)
    else
      render :action => "edit"
    end
  end

  def destroy
    @hop = Hop.find(params[:id])
    @hop.destroy

    redirect_to(hops_url)
  end

end
