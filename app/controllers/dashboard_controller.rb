class DashboardController < ApplicationController

  def index
    @user = Rockstar::User.new(session[:username])
    @artists = Artist.rank_by_top_tags(@user)#, tolerance=0.25
  end

end
