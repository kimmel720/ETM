class RemoveImgPathFromArtworks < ActiveRecord::Migration
  def change
    remove_column :artworks, :img_path, :string
  end
end
