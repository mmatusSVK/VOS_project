class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answers

  default_scope -> { order(created_at: :desc) }
  #TODO question validation
end
