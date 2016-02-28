class CreateArtworksRoomsJoinTable < ActiveRecord::Migration
  def change
    def change
      # pass id: false because table does not represent model
      create_table :artworks_rooms, id: false do |t|
        t.integer :artwork_id
        t.integer :room_id
      end

      add_index :artworks_rooms, :artwork_id
      add_index :artworks_rooms, :room_id
    end
  end
end
