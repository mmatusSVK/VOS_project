class AddIsHiddenToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :is_hidden, :boolean
  end
end
