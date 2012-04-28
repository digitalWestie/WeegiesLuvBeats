class Artist < ActiveRecord::Base
  
  has_many :tracks, :dependent => :destroy
  validates_presence_of :name

  def self.find_for_user(user, key)
    lastfm_rec = user.recommended_artists(key)
    names = lastfm_rec.collect { |a| a.name }
    return Artist.find_all_by_name(names)
    #1 artists by lastfm recommendations

    #2 artists by tags
  end

	scope :have_data, where(:has_entry => true)
  
end
