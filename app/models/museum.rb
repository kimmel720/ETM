class Museum < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user

  has_many :exhibitions
  geocoded_by :address
  after_validation :geocode
end
