require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test 'result without variable' do
    result = IgnazSchema.execute(query_for_region)

    covid_cases = result['data']['covidCases']

    assert_equal CovidCase.count, covid_cases.count
  end

  test 'result with variable' do
    variables = { "region" => "ZG" }
    result = IgnazSchema.execute(query_for_region, variables: variables)

    covid_cases = result['data']['covidCases']
    assert covid_cases.count.positive?

    covid_cases.first.tap do |covid_case|
      assert_equal '2020-03-20', covid_case['date']
      assert_equal '', covid_case['time']
      assert_equal 'ZG', covid_case['abbreviationCantonAndFl']

      assert_equal 9, covid_case['ncumulTested']
      assert_equal 9, covid_case['ndeltaTested']

      assert_equal 48, covid_case['ncumulConf']
      assert_equal 9, covid_case['ndeltaConf']

      assert_equal 1, covid_case['ncumulHosp']
      assert_equal 0, covid_case['ndeltaHosp']

      assert_nil covid_case['ncumulIcu']
      assert_nil covid_case['ndeltaIcu']

      assert_nil covid_case['ncumulVent']
      assert_nil covid_case['ndeltaVent']

      assert_equal 15, covid_case['ncumulReleased']
      assert_equal 9, covid_case['ndeltaReleased']

      assert_equal 2, covid_case['ncumulDeceased']
      assert_equal 2, covid_case['ndeltaDeceased']
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
          ncumulTested
          ndeltaTested
          ncumulConf
          ndeltaConf
          ncumulHosp
          ndeltaHosp
          ncumulIcu
          ndeltaIcu
          ncumulVent
          ndeltaVent
          ncumulReleased
          ndeltaReleased
          ncumulDeceased
          ndeltaDeceased
          ninstantIcuIntub
          source
        }
      }
    GQL
  end
end
