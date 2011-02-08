class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to hours_path
    else
      flash[:notice] = "Couldn't login"
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] =  "Logged out"
    redirect_to hours_path
  end


end
