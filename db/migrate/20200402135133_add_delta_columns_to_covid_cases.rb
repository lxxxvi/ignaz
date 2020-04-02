class AddDeltaColumnsToCovidCases < ActiveRecord::Migration[6.0]
  def change
    change_table :covid_cases, bulk: true do |t|
      t.integer :ndelta_tested, null: true
      t.integer :ndelta_conf, null: true
      t.integer :ndelta_hosp, null: true
      t.integer :ndelta_icu, null: true
      t.integer :ndelta_vent, null: true
      t.integer :ndelta_released, null: true
      t.integer :ndelta_deceased, null: true
    end
  end
end
