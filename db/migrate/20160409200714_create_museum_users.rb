class CreateMuseumUsers < ActiveRecord::Migration
  def change
    create_table :museum_users do |t|

      t.timestamps null: false
    end
  end
end
