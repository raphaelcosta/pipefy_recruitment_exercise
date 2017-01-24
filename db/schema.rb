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

ActiveRecord::Schema.define(version: 20170124001029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer  "phase_id"
    t.integer  "external_id"
    t.string   "title"
    t.date     "due_date"
    t.float    "index"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["phase_id"], name: "index_cards_on_phase_id", using: :btree
  end

  create_table "field_values", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "external_id"
    t.string   "value"
    t.string   "display_value"
    t.integer  "external_field_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["card_id"], name: "index_field_values_on_card_id", using: :btree
  end

  create_table "fields", force: :cascade do |t|
    t.integer  "phase_id"
    t.integer  "external_id"
    t.string   "label"
    t.string   "description"
    t.boolean  "is_title_field"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["phase_id"], name: "index_fields_on_phase_id", using: :btree
  end

  create_table "labels", force: :cascade do |t|
    t.integer  "pipe_id"
    t.integer  "external_id"
    t.string   "name"
    t.string   "color"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["pipe_id"], name: "index_labels_on_pipe_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.integer  "external_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "phases", force: :cascade do |t|
    t.integer  "pipe_id"
    t.integer  "external_id"
    t.string   "name"
    t.string   "description"
    t.boolean  "done"
    t.float    "index"
    t.boolean  "draft"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["pipe_id"], name: "index_phases_on_pipe_id", using: :btree
  end

  create_table "pipes", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "external_id"
    t.string   "name"
    t.string   "token"
    t.boolean  "can_edit"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_pipes_on_organization_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "pipe_id"
    t.integer  "external_id"
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "display_username"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["pipe_id"], name: "index_users_on_pipe_id", using: :btree
  end

end
