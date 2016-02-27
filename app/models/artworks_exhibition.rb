class ArtworksExhibition < ActiveRecord::Base
  belongs_to :artwork
  belongs_to :exhibition
end
