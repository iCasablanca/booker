class HoursController < ApplicationController
  def show
    @hours = Hours.find(params[:id])
  end

  def new
    @hours = Hours.new
  end

  def create
    @hours = Hours.new(params[:hours])
    if @hours.save
      render 'new'
    else
      render 'new'
    end
  end

end
