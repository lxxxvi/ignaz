module DeltaColumnsUpdater
  module_function

  def call
    CovidCase.connection.execute(delta_columns_upsert_sql)
  end

  def delta_columns_upsert_sql
    <<~SQL
      WITH covid_cases_deltas AS (
        SELECT t.abbreviation_canton_and_fl
             , t.date
             , t.time
             , (t.ncumul_tested - COALESCE(t.ncumul_tested_before, 0))      AS ndelta_tested
             , (t.ncumul_conf - COALESCE(t.ncumul_conf_before, 0))          AS ndelta_conf
             , (t.ncumul_hosp - COALESCE(t.ncumul_hosp_before, 0))          AS ndelta_hosp
             , (t.ncumul_icu - COALESCE(t.ncumul_icu_before, 0))            AS ndelta_icu
             , (t.ncumul_vent - COALESCE(t.ncumul_vent_before, 0))          AS ndelta_vent
             , (t.ncumul_released - COALESCE(t.ncumul_released_before, 0))  AS ndelta_released
             , (t.ncumul_deceased - COALESCE(t.ncumul_deceased_before, 0))  AS ndelta_deceased
          FROM (
              SELECT abbreviation_canton_and_fl
                   , date
                   , time
                   , ncumul_tested
                   , LAG(ncumul_tested) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)    AS ncumul_tested_before
                   , ncumul_conf
                   , LAG(ncumul_conf) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)      AS ncumul_conf_before
                   , ncumul_hosp
                   , LAG(ncumul_hosp) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)      AS ncumul_hosp_before
                   , ncumul_icu
                   , LAG(ncumul_icu) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)       AS ncumul_icu_before
                   , ncumul_vent
                   , LAG(ncumul_vent) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)      AS ncumul_vent_before
                   , ncumul_released
                   , LAG(ncumul_released) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)  AS ncumul_released_before
                   , ncumul_deceased
                   , LAG(ncumul_deceased) OVER (PARTITION BY abbreviation_canton_and_fl ORDER BY abbreviation_canton_and_fl, date, time)  AS ncumul_deceased_before
                FROM covid_cases
            GROUP BY abbreviation_canton_and_fl
                   , date
                   , time
                   , ncumul_tested
                   , ncumul_conf
                   , ncumul_hosp
                   , ncumul_icu
                   , ncumul_vent
                   , ncumul_released
                   , ncumul_deceased
              ) t
      )
      INSERT INTO covid_cases (abbreviation_canton_and_fl
                             , date
                             , time
                             , ndelta_tested
                             , ndelta_conf
                             , ndelta_hosp
                             , ndelta_icu
                             , ndelta_vent
                             , ndelta_released
                             , ndelta_deceased
                             , created_at
                             , updated_at)
      SELECT abbreviation_canton_and_fl
           , date
           , time
           , ndelta_tested
           , ndelta_conf
           , ndelta_hosp
           , ndelta_icu
           , ndelta_vent
           , ndelta_released
           , ndelta_deceased
           , NOW()
           , NOW()
        FROM covid_cases_deltas ccd
        ON CONFLICT (abbreviation_canton_and_fl, date, time)
        DO
        UPDATE SET ndelta_tested = EXCLUDED.ndelta_tested,
                   ndelta_conf = EXCLUDED.ndelta_conf,
                   ndelta_hosp = EXCLUDED.ndelta_hosp,
                   ndelta_icu = EXCLUDED.ndelta_icu,
                   ndelta_vent = EXCLUDED.ndelta_vent,
                   ndelta_released = EXCLUDED.ndelta_released,
                   ndelta_deceased = EXCLUDED.ndelta_deceased
    SQL
  end
end
