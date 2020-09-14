require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test 'result without variable' do
    result = IgnazSchema.execute(query_for_region)

    covid_cases = result['data']['covidCases']

    assert_equal CovidCase.count, covid_cases.count
  end

  test 'result with variable' do
    variables = { 'region' => 'ZG' }
    result = IgnazSchema.execute(query_for_region, variables: variables)

    covid_cases = result['data']['covidCases']
    assert covid_cases.count.positive?

    covid_cases.first.tap do |covid_case|
      assert_equal '2020-03-20', covid_case['date']
      assert_equal '', covid_case['time']
      assert_equal 'ZG', covid_case['abbreviationCantonAndFl']

      assert_equal 9, covid_case['testedTotal']
      assert_equal 9, covid_case['testedTotalDelta']

      assert_equal 48, covid_case['confirmedTotal']
      assert_equal 9, covid_case['confirmedTotalDelta']

      assert_equal 1, covid_case['hospitalizedCurrent']
      assert_equal 0, covid_case['hospitalizedCurrentDelta']

      assert_nil covid_case['icuCurrent']
      assert_nil covid_case['icuCurrentDelta']

      assert_nil covid_case['ventilationCurrent']
      assert_nil covid_case['ventilationCurrentDelta']

      assert_equal 15, covid_case['releasedTotal']
      assert_equal 9, covid_case['releasedTotalDelta']

      assert_equal 2, covid_case['deceasedTotal']
      assert_equal 2, covid_case['deceasedTotalDelta']
    end
  end

  private

  def query_for_region
    <<~GQL
      query getCovidCases($region: String) {
        covidCases(abbreviationCantonAndFl: $region) {
          date
          time
          abbreviationCantonAndFl
          testedTotal
          testedTotalDelta
          confirmedTotal
          confirmedTotalDelta
          hospitalizedCurrent
          hospitalizedCurrentDelta
          icuCurrent
          icuCurrentDelta
          ventilationCurrent
          ventilationCurrentDelta
          releasedTotal
          releasedTotalDelta
          deceasedTotal
          deceasedTotalDelta
          source
        }
      }
    GQL
  end
end
