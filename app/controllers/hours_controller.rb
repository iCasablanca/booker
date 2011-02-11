class HoursController < ApplicationController
  def index
    @hours = Hour.find(:all)
  end

  def show
    @hour = Hour.find(params[:id])
    @slots = @hour.slots.sort_by(&:start)
    @slot = Slot.new
    
  end

  def new    
    @hour = Hour.new
  end

  def create
    @hour = Hour.new(params[:hour])
    if @hour.save
      redirect_to hours_path
    else
      render 'new'
    end
  end

end
