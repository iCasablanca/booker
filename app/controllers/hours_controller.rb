require 'google_util'

class HoursController < ApplicationController
  def index
    puts request.env['omniauth.auth'].inspect
    @hours = Hour.find(:all)
    @hour = Hour.new
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

  def callback
    if current_user
      current_user.oauth_token = request.env['omniauth.auth']['credentials']['token']
      current_user.oauth_secret = request.env['omniauth.auth']['credentials']['secret']
      current_user.save!
    end
    
    redirect_to :action => 'index'
  end
end

