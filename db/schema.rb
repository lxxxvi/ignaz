# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_16_110356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "covid_cases", force: :cascade do |t|
    t.date "date", null: false
    t.string "time", default: "00:00", null: false
    t.string "abbreviation_canton_and_fl", null: false
    t.integer "tested_total"
    t.integer "tested_total_delta"
    t.integer "confirmed_total"
    t.integer "confirmed_total_delta"
    t.integer "hospitalized_new"
    t.integer "hospitalized_current"
    t.integer "hospitalized_current_delta"
    t.integer "icu_current"
    t.integer "icu_current_delta"
    t.integer "ventilation_current"
    t.integer "ventilation_current_delta"
    t.integer "released_total"
    t.integer "released_total_delta"
    t.integer "deceased_total"
    t.integer "deceased_total_delta"
    t.string "source"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["abbreviation_canton_and_fl", "date", "time"], name: "indx_canton_date_time", unique: true
  end

end
