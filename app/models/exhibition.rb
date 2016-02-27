class Exhibition < ActiveRecord::Base
  belongs_to :museums
  has_and_belongs_to_many :artworks
  has_many :floor_plans
  has_many :panoramas, through: :floor_plans
end
