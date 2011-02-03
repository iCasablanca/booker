class SlotsController < ApplicationController
  def create
    @hour = Hour.find(params[:hour_id])
    @slot = @hour.slots.build(params[:slot])
    if @slot.save
      flash[:success] = "slot created"
      redirect_to hours_path
    else
      redirect_to hours_path
    end
  end

  def edit
    @slot = Slot.find(params[:id])
  end

  def update
    @slot = Slot.find(params[:id])
    if @slot.update_attributes(params[:slot])
      hour = @slot.hour_id
      redirect_to hour_path(hour)
    end
  end

  def cancel
  end
end
