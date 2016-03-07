class Artwork < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :rooms

  has_and_belongs_to_many :artists
end
