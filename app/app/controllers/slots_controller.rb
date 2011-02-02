class SlotsController < ApplicationController
  def create
    @slot = @hours_id.slot.build(params[:slot])
    if @slot.save
      flash[:success] = "slot created"
    else
      redirect_to hours_path
    end
  end
end
