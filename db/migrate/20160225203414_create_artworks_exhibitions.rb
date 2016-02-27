class CreateArtworksExhibitions < ActiveRecord::Migration
  def change
    create_table :artworks_exhibitions do |t|
      t.references :artwork_id, index: true, foreign_key: true
      t.references :exhibition_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
