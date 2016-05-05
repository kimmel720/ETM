class Panorama < ActiveRecord::Base
  attachment :image
  serialize :art_coordinates, Hash
  serialize :pan_coordinates, Hash

  

  belongs_to :exhibition

  def as_json(options={})
    { :artwork_coordinates => self.coordinates,
      :image_url => nil
    }
  end

end
