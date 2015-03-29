class User < ActiveRecord::Base
  validates(:login_name, uniqueness:{case_sensitive: false})

  has_secure_password
  has_many :topics, dependent: :destroy
end