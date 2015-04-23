class AddIsHiddenToTests < ActiveRecord::Migration
  def change
    add_column :tests, :is_hidden, :boolean, value: false
  end
end
