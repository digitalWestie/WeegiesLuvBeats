class DashboardController < ApplicationController

  def index
    #@user = Rockstar::User.new(session[:username])
    @user = Rockstar::User.new('digitalWestie')
    artists = Artist.rank_by_top_tags(@user, 0.25)#, tolerance=0.25
    #    artists = Artist.have_data.all[0 .. 20]
    @artists = []
    for a in artists
      a = Rockstar::Artist.new(a.name, :include_info => true)
      @artists << a
    end
  end

end
