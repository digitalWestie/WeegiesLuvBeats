class DashboardController < ApplicationController

  def index
    @user = Rockstar::User.new(session[:username])
    @artists = Artist.rank_by_top_tags(@user, 0.5)#, tolerance=0.25
  end

end
