class CovidCase < ApplicationRecord
  include RegionScopes

  scope :ordered_by_region, -> { order(:abbreviation_canton_and_fl) }
  scope :ordered_chronologically, -> { order(:date, :time) }
  scope :for_region, ->(region) {
    return all if region.nil?

    where(abbreviation_canton_and_fl: region)
  }

  before_validation :set_defaults

  private

  def set_defaults
    self.time ||= self.class.column_defaults['time']
  end
end
