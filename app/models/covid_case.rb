class CovidCase < ApplicationRecord
  include RegionScopes

  scope :ordered_chronologically, -> { order(:date, :time) }
end
