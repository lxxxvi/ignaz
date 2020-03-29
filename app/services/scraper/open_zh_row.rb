class Scraper::OpenZhRow
  DEFAULTS = { time: '00:00' }.freeze

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
      ncumul_tested: ncumul_tested,
      ncumul_conf: ncumul_conf,
      ncumul_hosp: ncumul_hosp,
      ncumul_ICU: ncumul_ICU,
      ncumul_vent: ncumul_vent,
      ncumul_released: ncumul_released,
      ncumul_deceased: ncumul_deceased,
      ninstant_ICU_intub: ninstant_ICU_intub,
      source: source
    }
  end

  def date
    @csv_row['date']
  end

  def time
    @csv_row['time'] || DEFAULTS[:time]
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

  def ncumul_hosp
    @csv_row['ncumul_hosp']
  end

  def ncumul_ICU
    @csv_row['ncumul_ICU']
  end

  def ncumul_vent
    @csv_row['ncumul_vent']
  end

  def ncumul_released
    @csv_row['ncumul_released']
  end

  def ncumul_deceased
    @csv_row['ncumul_deceased']
  end

  def ninstant_ICU_intub
    @csv_row['ninstant_ICU_intub']
  end

  def source
    @csv_row['source']
  end
end
