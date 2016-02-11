class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :name
      t.string :artist
      t.string :description
      t.string :owner
      t.string :accession_number
      t.string :three_d_model_path
      t.string :picture_path

      t.timestamps null: false
    end
  end
end
