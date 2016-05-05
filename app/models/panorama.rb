class Panorama < ActiveRecord::Base
  attachment :image
  serialize :coordinates, Hash

  has_and_belongs_to_many :adjacent_panoramas,
                          class_name: "Panorama",
                          join_table: :adjacency,
                          foreign_key: :panorama_id,
                          association_foreign_key: :adjacent_panorama_id

  belongs_to :exhibition

  def as_json(options={})
    { :artwork_coordinates => self.artwork_coordinates,
      :image_url => nil
    }
  end

end
