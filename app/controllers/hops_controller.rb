class HopsController < ApplicationController
  before_filter :find_hop,
    only: [:show, :edit, :update, :destroy]

private
  def find_hop
    @hop = Hop.find params[:id]
  end

public

  def index
    @hops = Hop.order :name
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @hop }
    end
  end


  def new
    authorize! :create, Hop
    @hop = Hop.new
  end


  def edit
    authorize! :update, @hop
  end


  def create
    authorize! :create, Hop
    @hop = Hop.new(params[:hop])

    if @hop.save
      flash[:notice] = 'Hop was successfully created.'
      redirect_to(@hop)
    else
      render :action => "new"
    end
  end


  def update
    authorize! :update, @hop

    if @hop.update_attributes(params[:hop])
      flash[:notice] = 'Hop was successfully updated.'
      redirect_to(@hop)
    else
      render :action => "edit"
    end
  end

  def destroy
    authorize! :destroy, @hop

    @hop.destroy
    redirect_to(hops_url)
  end

end
