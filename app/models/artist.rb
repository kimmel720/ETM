class Artist < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :artworks

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
