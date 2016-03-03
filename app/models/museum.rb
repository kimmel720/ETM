class Museum < ActiveRecord::Base
  has_many :exhibitions
  geocoded_by :address
  after_validation :geocode
end
