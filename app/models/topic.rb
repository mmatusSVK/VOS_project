class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :current_tests, dependent: :destroy
  has_many :user_answers

  default_scope -> { order(created_at: :desc) }

  validates(:user_id, presence: true)
  validates(:topic_name, presence: true, length: {minimum:3, maximum: 100})
  validates(:information, presence: true, length: {minimum:10})
end
