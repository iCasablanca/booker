class HoursController < ApplicationController
  def index
    puts request.env['omniauth.auth'].inspect
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

  def callback
    if current_user
      current_user.oauth_token = request.env['omniauth.auth']['credentials']['token']
      current_user.oauth_secret = request.env['omniauth.auth']['credentials']['secret']
      current_user.save!
    end
    
    redirect_to :action => 'index'
  end

   def example_request
    oauth_consumer = OAuth::Consumer.new("crontab.org", "oGiQSnxe/Ryq22jGwBxZrLP0")
    access_token = OAuth::AccessToken.new(oauth_consumer, current_user.oauth_token, current_user.oauth_secret)
    client = Google::Client.new(access_token, '2.0');

    # Here is where you specify the get. You can pass parameters into the hash. See the gdata spec.
    feed = client.get('https://www.google.com/calendar/feeds/default/allcalendars/full', {})

    output = ""
    feed.elements.each('//entry') do |entry|
      output += entry.elements["title"].text + "<br>"
    end

    render :text => output
  end


end
