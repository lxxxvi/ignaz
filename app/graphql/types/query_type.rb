module Types
  class QueryType < Types::BaseObject
    field :covid_cases, [CovidCaseType], null: false do
      description 'Covid cases'
      argument :abbreviation_canton_and_fl, String, required: false
    end

    def covid_cases(abbreviation_canton_and_fl:)
      CovidCase.for_region(abbreviation_canton_and_fl)
               .ordered_by_region
               .ordered_chronologically
    end
  end
end
