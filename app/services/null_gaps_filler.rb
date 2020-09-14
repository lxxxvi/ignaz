module NullGapsFiller
  module_function

  def call
    CovidCase.connection.execute(sql)
  end

  def sql
    <<~SQL.squish
      WITH corrected_totals AS (
        SELECT date
             , time
             , abbreviation_canton_and_fl
             , tested_total
             , group_tested_total
             , first_value(tested_total) OVER (PARTITION BY abbreviation_canton_and_fl, group_tested_total ORDER BY date, time) AS corrected_tested_total
             , confirmed_total
             , group_confirmed_total
             , first_value(confirmed_total) OVER (PARTITION BY abbreviation_canton_and_fl, group_confirmed_total ORDER BY date, time) AS corrected_confirmed_total
             , released_total
             , group_released_total
             , first_value(released_total) OVER (PARTITION BY abbreviation_canton_and_fl, group_released_total ORDER BY date, time) AS corrected_released_total
             , deceased_total
             , group_deceased_total
             , first_value(deceased_total) OVER (PARTITION BY abbreviation_canton_and_fl, group_deceased_total ORDER BY date, time) AS corrected_deceased_total
             , hospitalized_current
             , group_hospitalized_current
             , first_value(hospitalized_current) OVER (PARTITION BY abbreviation_canton_and_fl, group_hospitalized_current ORDER BY date, time) AS corrected_hospitalized_current
             , icu_current
             , group_icu_current
             , first_value(icu_current) OVER (PARTITION BY abbreviation_canton_and_fl, group_icu_current ORDER BY date, time) AS corrected_icu_current
             , ventilation_current
             , group_ventilation_current
             , first_value(ventilation_current) OVER (PARTITION BY abbreviation_canton_and_fl, group_ventilation_current ORDER BY date, time) AS corrected_ventilation_current
          FROM (
          SELECT date
               , time
               , abbreviation_canton_and_fl
               , tested_total
               , sum(CASE WHEN tested_total IS NOT NULL THEN 1 END) OVER (ORDER BY abbreviation_canton_and_fl, date, time) AS group_tested_total
               , confirmed_total
               , sum(CASE WHEN confirmed_total IS NOT NULL THEN 1 END) OVER (ORDER BY abbreviation_canton_and_fl, date, time) AS group_confirmed_total
               , released_total
               , sum(CASE WHEN released_total IS NOT NULL THEN 1 END) OVER (ORDER BY abbreviation_canton_and_fl, date, time) AS group_released_total
               , deceased_total
               , sum(CASE WHEN deceased_total IS NOT NULL THEN 1 END) OVER (ORDER BY abbreviation_canton_and_fl, date, time) AS group_deceased_total
               , hospitalized_current
               , sum(CASE WHEN hospitalized_current IS NOT NULL THEN 1 END) OVER (ORDER BY abbreviation_canton_and_fl, date, time) AS group_hospitalized_current
               , icu_current
               , sum(CASE WHEN icu_current IS NOT NULL THEN 1 END) OVER (ORDER BY abbreviation_canton_and_fl, date, time) AS group_icu_current
               , ventilation_current
               , sum(CASE WHEN ventilation_current IS NOT NULL THEN 1 END) OVER (ORDER BY abbreviation_canton_and_fl, date, time) AS group_ventilation_current
            FROM covid_cases
        ) t
        ORDER BY abbreviation_canton_and_fl, date, time
      )
      INSERT INTO covid_cases (abbreviation_canton_and_fl
                             , date
                             , time
                             , tested_total
                             , confirmed_total
                             , released_total
                             , deceased_total
                             , hospitalized_current
                             , icu_current
                             , ventilation_current
                             , created_at
                             , updated_at)
      SELECT abbreviation_canton_and_fl
           , date
           , time
           , corrected_tested_total
           , corrected_confirmed_total
           , corrected_released_total
           , corrected_deceased_total
           , corrected_hospitalized_current
           , corrected_icu_current
           , corrected_ventilation_current
           , NOW()
           , NOW()
        FROM corrected_totals ct
        ON CONFLICT (abbreviation_canton_and_fl, date, time)
        DO
        UPDATE SET tested_total = EXCLUDED.tested_total
                 , confirmed_total = EXCLUDED.confirmed_total
                 , released_total = EXCLUDED.released_total
                 , deceased_total = EXCLUDED.deceased_total
                 , hospitalized_current = EXCLUDED.hospitalized_current
                 , icu_current = EXCLUDED.icu_current
                 , ventilation_current = EXCLUDED.ventilation_current
    SQL
  end
end
