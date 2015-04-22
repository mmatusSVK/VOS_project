class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :user_answers
  default_scope -> { order(created_at: :desc) }

  #TODO answer validation
end
