class Topic < ActiveRecord::Base
  belongs_to :user
  validates(:user_id, presence: true)
  validates(:topic_name, presence: true, length: {minimum:1, maximum: 50})
  validates(:information, presence: true, length: {minimum:1, maximum: 400})
#  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#  validates(:email, presence: true, length: { maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false})
#  validates(:password, length: {minimum: 6}, allow_blank: true)
#  has_secure_password


end
