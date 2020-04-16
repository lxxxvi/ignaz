class Scraper::OpenZhRow
  def initialize(csv_row)
    @csv_row = csv_row
  end

  def to_covid_case
    CovidCase.find_or_initialize_by(finder_attributes).tap do |covid_case|
      covid_case.assign_attributes(to_covid_case_attributes)
    end
  end

  def finder_attributes
    to_covid_case_attributes.slice(:date, :time, :abbreviation_canton_and_fl)
  end

  def to_covid_case_attributes
    {
      date: date,
      time: time,
      abbreviation_canton_and_fl: abbreviation_canton_and_fl,
      tested_total: ncumul_tested,
      tested_total_delta: nil,
      confirmed_total: ncumul_conf,
      confirmed_total_delta: nil,
      hospitalized_new: new_hosp,
      hospitalized_current: current_hosp,
      hospitalized_current_delta: nil,
      icu_current: current_icu,
      icu_current_delta: nil,
      ventilation_current: current_vent,
      ventilation_current_delta: nil,
      released_total: ncumul_released,
      released_total_delta: nil,
      deceased_total: ncumul_deceased,
      deceased_total_delta: nil,
      source: source
    }
  end

  def date
    @csv_row['date']
  end

  def time
    @csv_row['time'] || CovidCase.column_defaults['time']
  end

  def abbreviation_canton_and_fl
    @csv_row['abbreviation_canton_and_fl']
  end

  def ncumul_tested
    @csv_row['ncumul_tested']
  end

  def ncumul_conf
    @csv_row['ncumul_conf']
  end

  def new_hosp
    @csv_row['new_hosp']
  end

  def current_hosp
    @csv_row['current_hosp']
  end

  def current_icu
    @csv_row['current_icu']
  end

  def current_vent
    @csv_row['current_vent']
  end

  def ncumul_released
    @csv_row['ncumul_released']
  end

  def ncumul_deceased
    @csv_row['ncumul_deceased']
  end

  def source
    @csv_row['source']
  end
end
