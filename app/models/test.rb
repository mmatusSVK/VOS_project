class Test < ActiveRecord::Base
  belongs_to :user
  has_many :current_tests, dependent: :destroy
  has_many :user_answers
  has_many :topics, through: :current_tests

  accepts_nested_attributes_for :current_tests

  default_scope -> { order(created_at: :desc) }

  validates(:user_id, presence: true)
  validates(:test_name, presence: true, length: {minimum: 5})
  validate :is_min_duration

  def is_min_duration
    if(duration.strftime("%H").to_i * 3600 + duration.strftime("%M").to_i * 60) == 0
      errors.add(:duration, " cannot be 0.")
    end
  end
end
