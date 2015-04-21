class AddStartingDateToTests < ActiveRecord::Migration
  def change
    add_column :tests, :starting_date, :datetime
  end
end
