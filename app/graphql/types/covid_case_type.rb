module Types
  class CovidCaseType < Types::BaseObject
    description 'A covid case history entry'
    field :date, GraphQL::Types::ISO8601Date, null: false
    field :time, String, null: false
    field :abbreviation_canton_and_fl, String, null: false
    field :tested_total, Integer, null: true
    field :tested_total_delta, Integer, null: true
    field :confirmed_total, Integer, null: true
    field :confirmed_total_delta, Integer, null: true
    field :hospitalized_current, Integer, null: true
    field :hospitalized_current_delta, Integer, null: true
    field :icu_current, Integer, null: true
    field :icu_current_delta, Integer, null: true
    field :ventilation_current, Integer, null: true
    field :ventilation_current_delta, Integer, null: true
    field :released_total, Integer, null: true
    field :released_total_delta, Integer, null: true
    field :deceased_total, Integer, null: true
    field :deceased_total_delta, Integer, null: true
    field :source, String, null: true
  end
end
