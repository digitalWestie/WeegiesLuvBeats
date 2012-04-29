class DashboardController < ApplicationController

  def index
    @user = Rockstar::User.new(session[:username])
    
    tags = []
    @user.top_artists[0 .. 24].each {|artist| tags.concat(artist.top_tags[0 .. 4]) }
    
    @rankings = {}

    tolerance = 0.25
    tags.uniq.each { |tag| @rankings.merge!({tag.name => 0}) }
    tags.each { |tag| @rankings[tag.name] += tag.count.to_i }

    rank_arr = @rankings.to_a
    max = rank_arr.collect {|e| e[1] }.max #get highest tag count
    rank_arr.each {|e| e[1] = e[1].to_f/max }
    rank_arr.delete_if {|e| e[1] > tolerance } # keep crappy ones to get rid of
    rank_arr.each {|e| @rankings.delete(e[0]) }
    @rankings = @rankings.sort {|a,b| b[1] <=> a[1] }
    
  end

  def rank
    @user = Rockstar::User.new(session[:username])
    artists = Artist.rank_by_top_tags(params[:rankings])
    @artists = []
    for a in artists[0 .. 9]
      a = Rockstar::Artist.new(a.name, :include_info => true)
      @artists << a
    end
  end

end
