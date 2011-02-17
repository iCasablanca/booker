class CalendarController < ApplicationController
  def new
   @hour = GCal4Ruby::Service.new 
  end

  def create
    @username = params[:username]
    @password = params[:password]
    if @username.empty? or @password.empty?
      flash[:notice] = "Please enter Google Calendar login details"
      render :action => :login
    end
    begin
      @service = GCal4Ruby::Service.new
      @service.authenticate(params[:username], params[:password])
    rescue AuthenticationFailed
      flash[:notice] = "Login details incorrect"
      render :action => :login
    end
    session[:username] = params[:username]
    session[:password] = params[:password]
    redirect_to :controller => :hours, :action => :index
  end

  def redah
    redirect_to :controller => :hours, :action => :index
  end
end
