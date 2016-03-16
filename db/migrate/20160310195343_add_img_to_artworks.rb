class AddImgToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :img_id, :string
  end
end
