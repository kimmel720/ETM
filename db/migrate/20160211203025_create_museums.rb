class CreateMuseums < ActiveRecord::Migration
  def change
    create_table :museums do |t|
      t.string :name
      t.integer :latitude
      t.integer :longitude
      t.string :description

      t.timestamps null: false
    end
  end
end
