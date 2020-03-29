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

ActiveRecord::Schema.define(version: 2020_03_29_085746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cases", force: :cascade do |t|
    t.time "datetime", null: false
    t.string "abbreviation_canton_and_fl", null: false
    t.integer "ncumul_tested"
    t.integer "ncumul_conf"
    t.integer "ncumul_hosp"
    t.integer "ncumul_ICU"
    t.integer "ncumul_vent"
    t.integer "ncumul_released"
    t.integer "ncumul_deceased"
    t.integer "ninstant_ICU_intub"
    t.string "source"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["abbreviation_canton_and_fl", "datetime"], name: "index_cases_on_abbreviation_canton_and_fl_and_datetime", unique: true
  end

end
