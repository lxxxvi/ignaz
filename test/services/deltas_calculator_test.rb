require 'test_helper'

class DeltasCalculatorTest < ActiveSupport::TestCase
  test '#call' do
    covid_case = covid_cases(:fr_20200322).dup

    covid_case.update!(
      date: '2020-03-23',
      tested_total: 1,
      confirmed_total: 222,
      hospitalized_current: 30,
      icu_current: 9,
      ventilation_current: nil,
      released_total: 10,
      deceased_total: 4
    )

    DeltasCalculator.call

    covid_case.reload

    assert_equal 1, covid_case.tested_total_delta
    assert_equal 20, covid_case.confirmed_total_delta
    assert_equal(-2, covid_case.hospitalized_current_delta)
    assert_equal 1, covid_case.icu_current_delta
    assert_nil covid_case.ventilation_current_delta
    assert_equal 10, covid_case.released_total_delta
    assert_equal 1, covid_case.deceased_total_delta
  end
end
