class CreatePanoramas < ActiveRecord::Migration
  def change
    create_table :panoramas do |t|
      t.string :name
      t.integer :exhibition_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
