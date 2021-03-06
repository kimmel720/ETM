class Exhibition < ActiveRecord::Base
  validates :name, presence: true
  validates :museum_id, presence: true

  attachment :image
  attachment :floor_plan
  serialize :floor_plan_coordinates, Hash

  belongs_to :user
  belongs_to :museum
  has_many :panoramas
  has_many :artworks

  def self.search(search)
    where("name LIKE ? OR description LIKE ? OR curator LIKE ?", "%#{search}%","%#{search}%", "%#{search}%")
  end
end
