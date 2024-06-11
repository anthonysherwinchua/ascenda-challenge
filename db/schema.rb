# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_11_053337) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string "name", null: false
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "category"], name: "index_amenities_on_name_and_category", unique: true
  end

  create_table "amenities_hotels", id: false, force: :cascade do |t|
    t.bigint "hotel_id", null: false
    t.bigint "amenity_id", null: false
    t.index ["amenity_id", "hotel_id"], name: "index_amenities_hotels_on_amenity_id_and_hotel_id"
    t.index ["hotel_id", "amenity_id"], name: "index_amenities_hotels_on_hotel_id_and_amenity_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "hotel_id", null: false
    t.integer "destination_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id", null: false
    t.json "images", default: {}
    t.string "booking_conditions", default: [], array: true
    t.index ["hotel_id", "destination_id"], name: "index_hotels_on_hotel_id_and_destination_id", unique: true
    t.index ["location_id"], name: "index_hotels_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.string "zipcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "hotels", "locations"
end
