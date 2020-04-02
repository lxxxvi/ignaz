module Types
  class CovidCaseType < Types::BaseObject
    description 'A covid case history entry'
    field :date, GraphQL::Types::ISO8601Date, null: false
    field :time, String, null: false
    field :abbreviation_canton_and_fl, String, null: false
    field :ncumul_tested, Integer, null: true
    field :ncumul_conf, Integer, null: true
    field :ncumul_hosp, Integer, null: true
    field :ncumul_icu, Integer, null: true
    field :ncumul_vent, Integer, null: true
    field :ncumul_released, Integer, null: true
    field :ncumul_deceased, Integer, null: true
    field :ninstant_icu_intub, Integer, null: true
    field :source, String, null: true
  end
end
