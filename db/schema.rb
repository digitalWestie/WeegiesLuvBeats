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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120428054816) do

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_entry"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "count"
    t.string   "url"
    t.integer  "artist_id"
    t.integer  "track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["artist_id"], :name => "index_tags_on_artist_id"
  add_index "tags", ["track_id"], :name => "index_tags_on_track_id"

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.string   "album"
    t.string   "genre"
    t.string   "playlist"
    t.string   "server_location"
    t.integer  "plays"
    t.integer  "mood"
    t.string   "record_label"
    t.integer  "texture"
    t.string   "duration"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_entry"
  end

  add_index "tracks", ["artist_id"], :name => "index_tracks_on_artist_id"

end
