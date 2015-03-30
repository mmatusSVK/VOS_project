class AddInformationToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :information, :text
  end
end
