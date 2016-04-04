class Panorama < ActiveRecord::Base
  attachment :image
  serialize :artwork_coordinates, Hash

  belongs_to :exhibition
end
