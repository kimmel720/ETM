class Artwork < ActiveRecord::Base
  validates :name, presence: true
  attachment :image

  belongs_to :exhibition
  has_and_belongs_to_many :artists
end
