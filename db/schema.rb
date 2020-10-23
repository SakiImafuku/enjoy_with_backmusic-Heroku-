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

ActiveRecord::Schema.define(version: 2020_07_28_130514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "classifications", force: :cascade do |t|
    t.bigint "musicpost_id"
    t.bigint "taxon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["musicpost_id", "taxon_id"], name: "index_classifications_on_musicpost_id_and_taxon_id", unique: true
    t.index ["musicpost_id"], name: "index_classifications_on_musicpost_id"
    t.index ["taxon_id"], name: "index_classifications_on_taxon_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "musicpost_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["musicpost_id"], name: "index_comments_on_musicpost_id"
    t.index ["user_id", "musicpost_id"], name: "index_comments_on_user_id_and_musicpost_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "musicpost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["musicpost_id"], name: "index_favorites_on_musicpost_id"
    t.index ["user_id", "musicpost_id"], name: "index_favorites_on_user_id_and_musicpost_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "musicpost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["musicpost_id"], name: "index_histories_on_musicpost_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "memos", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "musicpost_id"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["musicpost_id"], name: "index_memos_on_musicpost_id"
    t.index ["user_id", "musicpost_id"], name: "index_memos_on_user_id_and_musicpost_id"
    t.index ["user_id"], name: "index_memos_on_user_id"
  end

  create_table "musicposts", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "overview"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_musicposts_on_title"
    t.index ["user_id"], name: "index_musicposts_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "musicpost_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["musicpost_id"], name: "index_notifications_on_musicpost_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "taxonomies", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_taxonomies_on_name", unique: true
    t.index ["position"], name: "index_taxonomies_on_position", unique: true
  end

  create_table "taxons", force: :cascade do |t|
    t.string "name"
    t.integer "taxonomy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_taxons_on_name", unique: true
    t.index ["taxonomy_id"], name: "index_taxons_on_taxonomy_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "self_introduction"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "musicposts"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "musicposts"
  add_foreign_key "favorites", "users"
  add_foreign_key "histories", "musicposts"
  add_foreign_key "histories", "users"
  add_foreign_key "memos", "musicposts"
  add_foreign_key "memos", "users"
end
