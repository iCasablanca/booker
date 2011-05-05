require 'google_util'

class HoursController < ApplicationController
  before_filter :load

  def load
    @hours = current_user.hours
    @hour = Hour.new
  end
  
  def create
    @hour = current_user.hours.build(params[:hour])
    respond_to do |format|
      if @hour.save
        format.html {redirect_to(hours_path, :notice => "Hours created")}
        format.js
        @hours = current_user.hours
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
      format.js 
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

