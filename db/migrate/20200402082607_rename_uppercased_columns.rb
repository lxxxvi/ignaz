class RenameUppercasedColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :covid_cases, 'ncumul_ICU', 'ncumul_icu'
    rename_column :covid_cases, 'ninstant_ICU_intub', 'ninstant_icu_intub'
  end
end
