class CreateNewCovidCases < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_cases do |t|
      t.date :date, null: false
      t.string :time, null: false, default: '00:00'
      t.string :abbreviation_canton_and_fl, null: false
      t.integer :tested_total, null: true
      t.integer :tested_total_delta, null: true
      t.integer :confirmed_total, null: true
      t.integer :confirmed_total_delta, null: true
      t.integer :hospitalized_new, null: true
      t.integer :hospitalized_current, null: true
      t.integer :hospitalized_current_delta, null: true
      t.integer :icu_current, null: true
      t.integer :icu_current_delta, null: true
      t.integer :ventilation_current, null: true
      t.integer :ventilation_current_delta, null: true
      t.integer :released_total, null: true
      t.integer :released_total_delta, null: true
      t.integer :deceased_total, null: true
      t.integer :deceased_total_delta, null: true
      t.string :source, null: true
      t.timestamps

      t.index [:abbreviation_canton_and_fl, :date, :time], name: "indx_canton_date_time", unique: true
    end
  end
end
