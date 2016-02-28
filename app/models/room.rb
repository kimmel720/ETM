class Room < ActiveRecord::Base
  belongs_to :exhibition
  has_many :artworks
end
