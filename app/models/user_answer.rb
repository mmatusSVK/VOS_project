class UserAnswer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :test

  validates(:student_id, presence: true)
  validates(:answer_id, presence: true)
  validates(:test_id, presence: true)
  validates(:starting_date, presence: true)
end
