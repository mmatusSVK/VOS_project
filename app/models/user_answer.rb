class UserAnswer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :test
end
