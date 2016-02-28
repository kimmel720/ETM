class AddAcessionNoToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :accession_no, :int
    # probably simpler than overriding primary key
    add_index :artworks, :accession_no
  end
end
