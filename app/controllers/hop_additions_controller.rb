class HopAdditionsController < ApplicationController

  def show
    @hop_addition = HopAddition.find(params[:id])
  end

end

