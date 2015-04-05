class Answer < ActiveRecord::Base
  belongs_to :question
  #TODO answer validation
end
