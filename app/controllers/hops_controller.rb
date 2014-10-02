class HopsController < ApplicationController
  before_filter :find_hop, only: [:show, :edit, :update, :destroy]

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
    @hop = Hop.new hop_params

    if @hop.save
      flash[:notice] = 'Hop was successfully created.'
      redirect_to(@hop)
    else
      render :new
    end
  end


  def update
    authorize! :update, @hop

    if @hop.update hop_params
      flash[:notice] = 'Hop was successfully updated.'
      redirect_to(@hop)
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @hop

    @hop.destroy
    redirect_to(hops_url)
  end

private

  def find_hop
    @hop = Hop.find params.require(:id)
  end

  def hop_params
    params.require(:hop).permit(
      :name, :alpha_acid, :beta_acid, :form,
      :typical_use, :notes, :origin)
  end

end

