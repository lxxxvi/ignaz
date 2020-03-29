module RegionScopes
  extend ActiveSupport::Concern

  included do
    scope :liechtenstein, -> { where(abbreviation_canton_and_fl: 'FL') }
  end

  class_methods do
    %w[AG AI AR BE BL BS FR GE GL GR JU LU NE NW OW SG SH SO SZ TG TI UR VD VS ZG ZH].each do |canton|
      define_method("canton_#{canton.downcase}") do
        where(abbreviation_canton_and_fl: canton)
      end
    end
  end
end
