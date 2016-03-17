class Room < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :museum

  has_and_belongs_to_many :artworks
end
