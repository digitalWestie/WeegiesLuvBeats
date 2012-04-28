class LastfmAuthController < ApplicationController

  def authorize
    redirect_to 'http://www.last.fm/api/auth/?api_key=267346c6269500db6f77d00088cf4068'
  end

  def callback
    if params[:token]    
      #redirect_to 'http://ws.audioscrobbler.com/2.0/?method=album.getSession'
      render :text => params[:token]       
    else
      render :text => "Borked! Couldnae login!"
    end
  end

end
