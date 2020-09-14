module DeltasCalculator
  module_function

  def call
    CovidCase.connection.execute(delta_columns_upsert_sql)
  end

  def delta_columns_upsert_sql
    <<~SQL.squish
      WITH covid_cases_deltas AS (
        SELECT t.abbreviation_canton_and_fl
             , t.date
             , t.time
             , (t.tested_total - COALESCE(t.tested_total_before, 0))      AS tested_total_delta
             , (t.confirmed_total - COALESCE(t.confirmed_total_before, 0))          AS confirmed_total_delta
             , (t.hospitalized_current - COALESCE(t.hospitalized_current_before, 0))          AS hospitalized_current_delta
             , (t.icu_current - COALESCE(t.icu_current_before, 0))            AS icu_current_delta
             , (t.ventilation_current - COALESCE(t.ventilation_current_before, 0))          AS ventilation_current_delta
             , (t.released_total - COALESCE(t.released_total_before, 0))  AS released_total_delta
             , (t.deceased_total - COALESCE(t.deceased_total_before, 0))  AS deceased_total_delta
          FROM (
              SELECT abbreviation_canton_and_fl
                   , date
                   , time
                   , tested_total
                   , LAG(tested_total) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)    AS tested_total_before
                   , confirmed_total
                   , LAG(confirmed_total) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)      AS confirmed_total_before
                   , hospitalized_current
                   , LAG(hospitalized_current) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)      AS hospitalized_current_before
                   , icu_current
                   , LAG(icu_current) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)       AS icu_current_before
                   , ventilation_current
                   , LAG(ventilation_current) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)      AS ventilation_current_before
                   , released_total
                   , LAG(released_total) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)  AS released_total_before
                   , deceased_total
                   , LAG(deceased_total) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)  AS deceased_total_before
                FROM covid_cases
            GROUP BY abbreviation_canton_and_fl
                   , date
                   , time
                   , tested_total
                   , confirmed_total
                   , hospitalized_current
                   , icu_current
                   , ventilation_current
                   , released_total
                   , deceased_total
              ) t
      )
      INSERT INTO covid_cases (abbreviation_canton_and_fl
                             , date
                             , time
                             , tested_total_delta
                             , confirmed_total_delta
                             , hospitalized_current_delta
                             , icu_current_delta
                             , ventilation_current_delta
                             , released_total_delta
                             , deceased_total_delta
                             , created_at
                             , updated_at)
      SELECT abbreviation_canton_and_fl
           , date
           , time
           , tested_total_delta
           , confirmed_total_delta
           , hospitalized_current_delta
           , icu_current_delta
           , ventilation_current_delta
           , released_total_delta
           , deceased_total_delta
           , NOW()
           , NOW()
        FROM covid_cases_deltas ccd
        ON CONFLICT (abbreviation_canton_and_fl, date, time)
        DO
        UPDATE SET tested_total_delta = EXCLUDED.tested_total_delta,
                   confirmed_total_delta = EXCLUDED.confirmed_total_delta,
                   hospitalized_current_delta = EXCLUDED.hospitalized_current_delta,
                   icu_current_delta = EXCLUDED.icu_current_delta,
                   ventilation_current_delta = EXCLUDED.ventilation_current_delta,
                   released_total_delta = EXCLUDED.released_total_delta,
                   deceased_total_delta = EXCLUDED.deceased_total_delta
    SQL
  end
end
