require 'google_util'

class HoursController < ApplicationController
  before_filter :load

  def load
    @hours = Hour.all
    @hour = Hour.new
  end
  
  def index
  end

  def create
    @hour = Hour.new(params[:hour])
    respond_to do |format|
      if @hour.save
        format.html {redirect_to(hours_path, :notice => "Hours created")}
        format.js
        @hours = Hour.all
      else
        format.html {render :action => "index"}
        format.js
      end
    end
  end

  def show
    @hour = Hour.find(params[:id])
    @slots = @hour.slots.sort_by(&:start)
    @slot = Slot.new
  end
  
  def destroy
    @hour = Hour.find(params[:id])
    @hour.destroy

    respond_to do |format|
      format.html { redirect_to(hours_path) }
      format.js { render :nothing => true }
    end
  end

  def callback
    if current_user
      current_user.oauth_token = request.env['omniauth.auth']['credentials']['token']
      current_user.oauth_secret = request.env['omniauth.auth']['credentials']['secret']
      current_user.save!
    end
  end
end

