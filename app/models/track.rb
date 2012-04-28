class Track < ActiveRecord::Base
  belongs_to :artist
  validates_presence_of [:name, :artist_id]
	scope :have_data, where(:has_entry => true)
end
