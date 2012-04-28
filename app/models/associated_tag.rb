class AssociatedTag < ActiveRecord::Base
  belongs_to :track
  belongs_to :artist
  belongs_to :tag

end
