class CreateArtworksExhibitionsJoinTable < ActiveRecord::Migration
  def change
    # pass id: false because table does not represent model
    create table :artworks_exhibitions, id: false do |t|
      t.integer :artwork_id
      t.integer :exhibition_id
    end

    add_index :artworks_exhibitions, :artwork_id
    add_index :artworks_exhibitions, :exhibition_id
  end
end
