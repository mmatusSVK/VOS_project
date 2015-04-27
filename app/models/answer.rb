class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :user_answers
  default_scope -> { order(created_at: :desc) }

  validates(:question_id, presence: true)
  validates(:is_right, presence: true)
  validates(:answer_name, presence: true, length: {minimum:3})
end
