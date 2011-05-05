require 'oauth'

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @hours = @user.hours
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "registered"
      redirect_to hours_path
    else
      render :action => 'new'
    end
  end
end
