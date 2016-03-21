class Panorama < ActiveRecord::Base
  belongs_to :exhibition
  serialize :artwork_coordinates, Hash
  attachment :image
end
