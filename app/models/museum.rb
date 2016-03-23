class Museum < ActiveRecord::Base
  validates :name, presence: true
  validates :user_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  attachment :image

  belongs_to :user
  has_many :exhibitions
  has_many :rooms, through: :exhibition
end
