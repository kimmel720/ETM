class InitializeDatabase < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.boolean :admin

      t.timestamps null: false
    end

    create_table :museums do |t|
      t.belongs_to :user, index:true
      t.string :image_id
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :street_address
      t.string :city
      t.string :country
      t.string :description
      t.string :website

      t.timestamps null: false
    end

    create_table :exhibitions do |t|
      t.belongs_to :museum, index:true
      t.belongs_to :user, index:true
      t.string :floor_plan_id
      t.string :image_id
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :description
      t.string :curator

      t.timestamps null: false
    end

    create_table :panoramas do |t|
      t.belongs_to :exhibition, index:true
      t.string :image_id
      t.integer :artwork_coordinates
      t.timestamps null: false
    end

    create_table :artworks do |t|
      t.belongs_to :exhibition, index:true
      t.string :name
      t.string :medium
      t.string :image_id
      t.text :description
      t.date :date_created
      t.integer :accession_no
      t.integer :left
      t.integer :right
      t.integer :top
      t.integer :bottom
      # t.integer :artist_id, foreign_key: true

      t.timestamps null: false
    end

    add_index :artworks, :accession_no

    create_table :artists do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :artists_artworks, id:false do |t|
      t.belongs_to :artist, index: true
      t.belongs_to :artwork, index: true
    end

    create_table :museum_users do |t|

      t.timestamps null: false
    end
  end
end
