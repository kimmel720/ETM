class Artwork < ActiveRecord::Base
  belongs_to :artists
  has_and_belongs_to_many :exhibitions
end
