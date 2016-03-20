class Exhibition < ActiveRecord::Base
  validates :name, presence: true
  attachment :image
  attachment :floor_plan
  serialize :floor_plan_coordinates, Hash

  belongs_to :user
  belongs_to :museum

  has_many :panoramas
  has_many :artworks
end
