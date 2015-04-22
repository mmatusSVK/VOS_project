class Test < ActiveRecord::Base
  belongs_to :user
  has_many :current_tests, dependent: :destroy
  has_many :user_answers

  accepts_nested_attributes_for :current_tests
end
