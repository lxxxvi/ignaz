class AddCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.time :datetime, null: false
      t.string :abbreviation_canton_and_fl, null: false
      t.integer :ncumul_tested, null: true
      t.integer :ncumul_conf, null: true
      t.integer :ncumul_hosp, null: true
      t.integer :ncumul_ICU, null: true
      t.integer :ncumul_vent, null: true
      t.integer :ncumul_released, null: true
      t.integer :ncumul_deceased, null: true
      t.integer :ninstant_ICU_intub, null: true
      t.string :source, null: true

      t.index [:abbreviation_canton_and_fl, :datetime], unique: true

      t.timestamps
    end
  end
end
