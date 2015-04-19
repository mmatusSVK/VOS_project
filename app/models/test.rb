class Test < ActiveRecord::Base
  belongs_to :user
  has_many :current_tests, dependent: :destroy

  accepts_nested_attributes_for :current_tests
end
