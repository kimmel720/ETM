class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :name
      t.string :img_path
      t.text :description
      t.date :date_created

      t.timestamps null: false
    end
  end
end
