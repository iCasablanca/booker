class PagesController < ApplicationController
  def home
    if current_user
      redirect_to(:controller => "hours", :action => "index")
    end
  end

end
