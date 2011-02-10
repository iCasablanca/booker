class UserSessionsController < ApplicationController
   def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "logged in"
      redirect_to hours_path
    else
      render :action => "new"
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logged out"
    redirect_to hours_path
  end

end
