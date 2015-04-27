class User < ActiveRecord::Base
  validates(:login_name, uniqueness:{case_sensitive: false})

  default_scope -> { order(created_at: :desc) }

  has_secure_password

  has_many :topics, dependent: :destroy
  has_many :tests, dependent: :destroy

  validates(:login_name, presence: true, format: { with: /\A\w+[ ]\w+\z/ })
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end