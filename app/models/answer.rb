class Answer < ActiveRecord::Base
  belongs_to :question
  default_scope -> { order(created_at: :desc) }

  validates(:question_id, presence: true)
  validates(:answer_name, presence: true, length: {minimum:3})

end
