class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answers ,dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates(:topic_id, presence: true)
  validates(:question_name, presence: true, length: {minimum:3})
end
