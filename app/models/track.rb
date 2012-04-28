class Track < ActiveRecord::Base

  belongs_to :artist

  has_many :associated_tags, :dependent => :destroy
  has_many :tags, :through => :associated_tags

  validates_presence_of [:name, :artist_id]
	scope :have_data, where(:has_entry => true)
end
