require 'test_helper'

class DeltaColumnsUpdaterTest < ActiveSupport::TestCase
  test '#call' do
    covid_case = covid_cases(:fr_20200322).dup

    covid_case.update!(
      date: '2020-03-23',
      ncumul_tested: 1,
      ncumul_conf: 222,
      ncumul_hosp: 30,
      ncumul_icu: 9,
      ncumul_vent: nil,
      ncumul_released: 10,
      ncumul_deceased: 4
    )

    DeltaColumnsUpdater.call

    covid_case.reload

    assert_equal 1, covid_case.ndelta_tested
    assert_equal 20, covid_case.ndelta_conf
    assert_equal -2, covid_case.ndelta_hosp
    assert_equal 1, covid_case.ndelta_icu
    assert_nil covid_case.ndelta_vent
    assert_equal 10, covid_case.ndelta_released
    assert_equal 1, covid_case.ndelta_deceased
  end
end
