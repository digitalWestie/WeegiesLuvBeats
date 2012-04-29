class Artist < ActiveRecord::Base
  
  has_many :tracks, :dependent => :destroy
  has_many :associated_tags, :dependent => :destroy
  has_many :tags, :through => :associated_tags
  
  validates_presence_of :name

  def self.find_for_user(user, key)
    lastfm_rec = user.recommended_artists(key)
    names = lastfm_rec.collect { |a| a.name }
    artists = Artist.find_all_by_name(names)
  end

  def self.rank_by_top_tags(ranking)
    artists = Artist.joins(:tags).where('tags.name' => ranking.keys).all
    artists.keep_if {|a| artists.count(a) > 2 }
    artists.uniq!
    artists.sort! { |a,b| b.rank(ranking) <=> a.rank(ranking) }
    return artists
  end

  def rank(rankings)
    score = 0
    for at in self.associated_tags.joins(:tag).where("tags.name" => rankings.keys)
      tag_score = 0
      tag_score = rankings[at.tag.name].to_i
      tag_score = tag_score * at.count
      score += tag_score
    end
    return score
  end

	scope :have_data, where(:has_entry => true)
  
end
