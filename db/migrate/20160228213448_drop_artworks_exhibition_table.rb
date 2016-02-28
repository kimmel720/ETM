class DropArtworksExhibitionTable < ActiveRecord::Migration
  def change
    drop_table :artworks_exhibition
  end
end
