class DashboardController < ApplicationController

  def index
    @username = session[:username]    
  end

end
