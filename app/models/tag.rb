class Tag < ActiveRecord::Base

  has_many :associated_tags, :dependent => :destroy
  has_many :tracks, :through => :associated_tags
  has_many :artists, :through => :associated_tags

end
