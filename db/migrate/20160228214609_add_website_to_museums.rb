class AddWebsiteToMuseums < ActiveRecord::Migration
  def change
    add_column :museums, :website, :string
  end
end
