class Artist < ActiveRecord::Base
  
  has_many :tracks, :dependent => :destroy
  validates_presence_of :name

  def self.find_for_user(user, key)
    lastfm_rec = user.recommend_artists(key)
    names = lastfm_rec.collect { |a| a.name }
    return Artist.find_all_by_name(names)
  end
  
end
