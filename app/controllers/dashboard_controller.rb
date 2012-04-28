class DashboardController < ApplicationController

  def index
    @user = Rockstar::User.new(session[:username])     
  end

end
