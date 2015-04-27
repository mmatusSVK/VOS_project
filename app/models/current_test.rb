class CurrentTest < ActiveRecord::Base
  belongs_to :test
  belongs_to :topic

  validates(:topic_id, presence: true)
  validates(:test_id, presence: true)
  validates(:questions_count, :numericality => { :greater_than => 0})
end
