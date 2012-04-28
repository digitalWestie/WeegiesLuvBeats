class LastfmAuthController < ApplicationController

  def get_token
    redirect_to "http://www.last.fm/api/auth/?api_key=267346c6269500db6f77d00088cf4068"
  end

  def callback
    if params[:token]    
      Rockstar.lastfm = {:api_key => "267346c6269500db6f77d00088cf4068", :api_secret => "246cd98ffc2cf2e80efd02658df2804a"}
      a = Rockstar::Auth.new
      session = a.session(params[:token])
      render :text => session
    else
      render :text => "Borked! Couldnae login!"
    end
  end

end
