class DropArtworksExhibitionsTable < ActiveRecord::Migration
  def change
    drop_table :artworks_exhibitions
  end
end
