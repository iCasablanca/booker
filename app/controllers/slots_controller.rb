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
    @email = params[:slot][:email]
    @slot = Slot.find(params[:id])
    hour = @slot.hour_id

    if @slot.email? && @email == @slot.email
      @slot.update_attributes(:email => "")
      redirect_to hour_path(hour)
    elsif @slot.email?
      redirect_to edit_slot_path(@slot.id)
    else
      @slot.update_attributes(:email => @email) #doesn't catch errors and don't like idea of nested if
      redirect_to hour_path(hour)
    end
  end
end




