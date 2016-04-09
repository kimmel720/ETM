class CreateAdjacency < ActiveRecord::Migration
  def change
    create_table :adjacencies, id: false do |t|
      t.integer :panorama_id
      t.integer :adjacent_panorama_id
    end

    add_index(:adjacencies, [:panorama_id, :adjacent_panorama_id], :unique => true)
    add_index(:adjacencies, [:adjacent_panorama_id, :panorama_id], :unique => true)
  end
end
