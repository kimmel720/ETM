class Artwork < ActiveRecord::Base
  has_and_belongs_to_many :artists
  # exhibition can get containing artworks thru rooms table
  has_and_belongs_to_many :rooms
end
