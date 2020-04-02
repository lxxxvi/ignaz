require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test 'result without variable' do
    result = IgnazSchema.execute(query_for_region)

    covid_cases = result['data']['covidCases']

    assert_equal CovidCase.count, covid_cases.count
  end

  test 'result with variable' do
    variables = { "region" => "FR" }
    result = IgnazSchema.execute(query_for_region, variables: variables)

    covid_cases = result['data']['covidCases']
    assert covid_cases.count.positive?

    covid_cases.first.tap do |covid_case|
      assert_equal '2020-03-22', covid_case['date']
      assert_equal '', covid_case['time']
      assert_equal 'FR', covid_case['abbreviationCantonAndFl']
      assert_equal nil, covid_case['ncumulTested']
      assert_equal 202, covid_case['ncumulConf']
      assert_equal 32, covid_case['ncumulHosp']
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
          ncumulConf
          ncumulHosp
          ncumulIcu
          ncumulVent
          ncumulReleased
          ncumulDeceased
          ninstantIcuIntub
          source
        }
      }
    GQL
  end
end
