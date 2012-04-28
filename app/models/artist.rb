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

  def self.rank_by_top_tags(user, tolerance=0.25)
    #fm_tags = user.top_tags.collect { |t| t.name }
    #tags = Tag.find_all_by_name(fm_tags)
    #artists = tags.collect { |t| t.artists }.flatten
    #return artists
    tags = []
    user.top_artists.each {|artist| tags.concat(artist.top_tags[0 .. 4]) }
    ranking = {}
    tags.uniq.each { |tag| ranking.merge!({tag.name => 0}) }
    tags.each { |tag| ranking[tag.name] += tag.count.to_i }

    rank_arr = ranking.to_a
    max = rank_arr.collect {|e| e[1] }.max #get highest tag count
    rank_arr.each {|e| e[1] = e[1].to_f/max }
    rank_arr.delete_if {|e| e[1] > tolerance } # keep crappy ones to get rid of
    rank_arr.each {|e| ranking.delete(e[0]) }

    artists = Artist.joins(:tags).where('tags.name' => ranking.keys).all
    artists.keep_if {|a| artists.count(a) > 2 }
    artists.uniq!
    artists.sort { |a,b| b.rank(ranking) <=> a.rank(ranking) }
    return artists
  end

  def rank(rankings)
    score = 0    
    for at in self.associated_tags
      tag_score = 0
      unless rankings[at.tag.name].nil?
        tag_score = rankings[at.tag.name] 
        tag_score = tag_score * at.count
        score += tag_score
      end
    end  
    return score
  end

	scope :have_data, where(:has_entry => true)
  
end
