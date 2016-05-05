# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160407202945) do

  create_table "adjacency", id: false, force: :cascade do |t|
    t.integer "panorama_id"
    t.integer "adjacent_panorama_id"
  end

  add_index "adjacency", ["adjacent_panorama_id", "panorama_id"], name: "index_adjacency_on_adjacent_panorama_id_and_panorama_id", unique: true
  add_index "adjacency", ["panorama_id", "adjacent_panorama_id"], name: "index_adjacency_on_panorama_id_and_adjacent_panorama_id", unique: true

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists_artworks", id: false, force: :cascade do |t|
    t.integer "artist_id"
    t.integer "artwork_id"
  end

  add_index "artists_artworks", ["artist_id"], name: "index_artists_artworks_on_artist_id"
  add_index "artists_artworks", ["artwork_id"], name: "index_artists_artworks_on_artwork_id"

  create_table "artworks", force: :cascade do |t|
    t.integer  "exhibition_id"
    t.string   "name"
    t.string   "medium"
    t.string   "image_id"
    t.text     "description"
    t.date     "date_created"
    t.integer  "accession_no"
    t.integer  "left"
    t.integer  "right"
    t.integer  "top"
    t.integer  "bottom"
    t.string   "catagory"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "artworks", ["accession_no"], name: "index_artworks_on_accession_no"
  add_index "artworks", ["exhibition_id"], name: "index_artworks_on_exhibition_id"

  create_table "exhibitions", force: :cascade do |t|
    t.integer  "museum_id"
    t.integer  "user_id"
    t.string   "floor_plan_id"
    t.string   "image_id"
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description"
    t.string   "curator"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "exhibitions", ["museum_id"], name: "index_exhibitions_on_museum_id"
  add_index "exhibitions", ["user_id"], name: "index_exhibitions_on_user_id"

  create_table "museum_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "museums", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "image_id"
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street_address"
    t.string   "city"
    t.string   "country"
    t.string   "description"
    t.string   "website"
    t.string   "color"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "museums", ["user_id"], name: "index_museums_on_user_id"

  create_table "panoramas", force: :cascade do |t|
    t.integer  "exhibition_id"
    t.string   "image_id"
    t.text     "coordinates"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "panoramas", ["exhibition_id"], name: "index_panoramas_on_exhibition_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
