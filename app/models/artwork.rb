class Artwork < ActiveRecord::Base
  validates :name, presence: true
<<<<<<< HEAD
  attachment :img
=======
  validates :image_id, presence: true, uniqueness: true
>>>>>>> 58690399a4dd812d10211a5ab4c3b4f0aef91a25

  attachment :image

  belongs_to :exhibition
  has_and_belongs_to_many :artists
end
