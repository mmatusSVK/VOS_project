class User < ActiveRecord::Base
  has_secure_password

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:login_name,:password,
                                 :password_confirmation)
  end
end