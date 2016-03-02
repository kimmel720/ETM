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

ActiveRecord::Schema.define(version: 20160302023508) do

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artworks", force: :cascade do |t|
    t.string   "name"
    t.string   "img_path"
    t.text     "description"
    t.date     "date_created"
    t.integer  "accession_no"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "artworks", ["accession_no"], name: "index_artworks_on_accession_no"

  create_table "artworks_rooms", id: false, force: :cascade do |t|
    t.integer "artwork_id"
    t.integer "room_id"
  end

  add_index "artworks_rooms", ["artwork_id"], name: "index_artworks_rooms_on_artwork_id"
  add_index "artworks_rooms", ["room_id"], name: "index_artworks_rooms_on_room_id"

  create_table "exhibitions", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description"
    t.string   "curator"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "museums", force: :cascade do |t|
    t.string   "name"
    t.integer  "latitude"
    t.integer  "longitude"
    t.string   "description"
    t.string   "website"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
