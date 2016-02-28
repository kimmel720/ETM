class AddCuratorsToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :curators, :string
  end
end
