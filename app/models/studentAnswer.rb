class StudentAnswer
  default_scope -> { order(created_at: :desc) }

  attr_accessor :question_id
  attr_accessor :answer_id
  attr_accessor :student_answ
end