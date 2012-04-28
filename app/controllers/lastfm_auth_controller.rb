class LastfmAuthController < ApplicationController

  def get_token
    redirect_to "http://www.last.fm/api/auth/?api_key=267346c6269500db6f77d00088cf4068"
  end

  def callback
    if params[:token]    
      redirect_to "http://ws.audioscrobbler.com/2.0/?method=auth.getsession&token=#{params[:token]}&api_key=267346c6269500db6f77d00088cf4068&api_sig=246cd98ffc2cf2e80efd02658df2804a"
      #render :text => params[:token]       
    else
      render :text => "Borked! Couldnae login!"
    end
  end

end
