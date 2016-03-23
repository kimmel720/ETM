class Panorama < ActiveRecord::Base
  validates :exhibition_id, presence: true

  attachment :image
  serialize :artwork_coordinates, Hash

  belongs_to :exhibition
end
