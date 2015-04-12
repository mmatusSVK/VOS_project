class TopicsInformationChangeType < ActiveRecord::Migration
  def up
    change_column(:topics, :information, :text)
  end

  def down
    change_column(:topics, :information, :string)
  end
end
