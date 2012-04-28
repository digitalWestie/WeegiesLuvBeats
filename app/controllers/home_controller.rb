class HomeController < ApplicationController
  
  def index
    artists = Artist.have_data.all.shuffle
    @artists = []

    i = 0
    until @artists.size > 12
      a = Rockstar::Artist.new(artists[i].name, :include_info => true)
      @artists << a unless a.image('large').blank?
      i+=1
    end
    
  end

  def about
  end

end
