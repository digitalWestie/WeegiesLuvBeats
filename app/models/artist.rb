class Artist < ActiveRecord::Base
  
  has_many :tracks, :dependent => :destroy
  has_many :associated_tags, :dependent => :destroy
  has_many :tags, :through => :associated_tags
  
  validates_presence_of :name

  def self.find_for_user(user, key)
    lastfm_rec = user.recommended_artists(key)
    names = lastfm_rec.collect { |a| a.name }
    artists = Artist.find_all_by_name(names)

    fm_tags = user.top_tags.collect { |t| t.name }
    tags = Tag.find_all_by_name(fm_tags)
    artists.concat(tags.collect { |t| t.artists }.flatten)
    return artists
  end

	scope :have_data, where(:has_entry => true)
  
end
