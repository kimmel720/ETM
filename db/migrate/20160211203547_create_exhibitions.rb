class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :description
      t.integer :museum_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
