class AddNameToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :name, :string
  end
end
