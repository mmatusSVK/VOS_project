class UserAnswer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :test
  default_scope -> { order(created_at: :desc) }
end
