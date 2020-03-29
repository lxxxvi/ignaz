class AddCovidCases < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_cases do |t|
      t.date :date, null: false
      t.string :time, null: false
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

      t.index [:abbreviation_canton_and_fl, :date, :time], unique: true, name: :indx_canton_date_time

      t.timestamps
    end
  end
end
