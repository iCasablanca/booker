class SlotsController < ApplicationController
  def create
    @hour = Hour.find(params[:hour_id])
    @slot = @hour.slots.build(params[:slot])
    if @slot.save
      flash[:success] = "slot created"
    else
      redirect_to hours_path
    end
  end
end
