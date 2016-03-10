class RemoveImgUrlFromArtworks < ActiveRecord::Migration
  def change
    remove_column :artworks, :img_url, :string
  end
end
