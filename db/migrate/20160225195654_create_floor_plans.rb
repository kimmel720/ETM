class CreateFloorPlans < ActiveRecord::Migration
  def change
    create_table :floor_plans do |t|
      t.string :name
      t.integer :exhibition_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
