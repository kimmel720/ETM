class CreateAdjacency < ActiveRecord::Migration
  def change
    create_table :adjacency, id: false do |t|
      t.integer :panorama_id
      t.integer :adjacent_panorama_id
    end

    add_index(:adjacency, [:panorama_id, :adjacent_panorama_id], :unique => true)
    add_index(:adjacency, [:adjacent_panorama_id, :panorama_id], :unique => true)
  end
end
