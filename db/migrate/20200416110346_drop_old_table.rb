class DropOldTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :covid_cases
  end

  def down
    # not intended
  end
end
