class UserAnswer < ActiveRecord::Base
  belongs_to :test
  belongs_to :topic
  belongs_to :question
  belongs_to :answer

  attr_accessor :answer_id

  validates(:student_id, presence: true)
  validates(:question_id, presence: true)
  validates(:topic_id, presence: true)
  validates(:test_id, presence: true)
  validates(:starting_date, presence: true)
  validates(:old_test_name, presence: true)
end
