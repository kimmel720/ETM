class Artwork < ActiveRecord::Base
  validates :name, presence: true

  validates :image_id, presence: true

  attachment :image

  belongs_to :exhibition
  has_and_belongs_to_many :artists
  has_many :floor_coordinates

  def self.search(search)
    where("name LIKE ? OR medium LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def floor_coordinates
    if !self.left.blank? || !self.right.blank? || !self.top.blank? || !self.bottom.blank?
      "#{self.left},#{self.top},#{self.right},#{self.bottom}"
    end
  end
end
