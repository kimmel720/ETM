class InitializeDatabase < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.boolean :admin

      t.timestamps null: false
    end

    create_table :museums do |t|
      t.string :name
      t.integer :latitude
      t.integer :longitude
      t.string :description
      t.string :website

      t.timestamps null: false
    end

    create_table :museums_users do |t|
      t.integer :museum_id
      t.integer :user_id
    end
    add_foreign_key :museums_users, :museum
    add_foreign_key :museums_users, :users
    add_index :museums_users, :museum_id
    add_index :museums_users, :user_id

    create_table :exhibitions do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :description
      t.string :curator
      # t.integer :museum_id, foreign_key: true # belongs_to does this automagically?

      t.timestamps null: false
    end

    create_table :rooms do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :artworks do |t|
      t.string :name
      t.string :img_path
      t.text :description
      t.date :date_created
      t.integer :accession_no
      # t.integer :artist_id, foreign_key: true

      t.timestamps null: false
    end

    add_index :artworks, :accession_no

    # pass id: false because table does not represent a model
    create_table :artworks_rooms, id: false do |t|
      t.integer :artwork_id
      t.integer :room_id
    end
    add_foreign_key :artworks_rooms, :artworks
    add_foreign_key :artworks_rooms, :rooms

    add_index :artworks_rooms, :artwork_id
    add_index :artworks_rooms, :room_id

    create_table :artists do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :artists_artworks do |t|
      t.integer :artist_id
      t.integer :artwork_id
    end
    add_foreign_key :artists_artworks, :artists
    add_foreign_key :artists_artworks, :artworks

    add_index :artists_artworks, :artist_id
    add_index :artists_artworks, :artwork_id
  end
end
