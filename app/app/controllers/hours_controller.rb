class HoursController < ApplicationController
  def show
    @hour = Hour.find(params[:id])
  end

  def new
    @hour = Hour.new
  end

  def create
    @hour = Hour.new(params[:hour])
    if @hour.save
      render 'new'
    else
      render 'new'
    end
  end

end
