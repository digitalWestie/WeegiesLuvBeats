class DashboardController < ApplicationController

  def index
    @user = Rockstar::User.new(session[:username])
    @artists = Artist.find_for_user(@user, session[:lastfm_key])
    @artists.uniq!
  end

end
