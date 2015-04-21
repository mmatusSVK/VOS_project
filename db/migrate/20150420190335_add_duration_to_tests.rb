class AddDurationToTests < ActiveRecord::Migration
  def change
    add_column :tests, :duration, :time
  end
end
