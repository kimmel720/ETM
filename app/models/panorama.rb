class Panorama < ActiveRecord::Base
  attachment :image
  serialize :artwork_coordinates, Hash

  has_and_belongs_to_many :adjacent_panoramas,
                          class_name: "Panorama",
                          join_table: :adjacency,
                          foreign_key: :panorama_id,
                          association_foreign_key: :adjacent_panorama_id                      

  belongs_to :exhibition
end
