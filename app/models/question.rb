class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answers
  #TODO question validation
end
