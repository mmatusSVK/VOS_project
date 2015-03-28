class UsersController < ApplicationController
  before_action :is_user_logged, only: [:show]
  before_action :am_i_right_user,   only: [:show]

  def show
    @user = find_by_index(params[:id])
  end



  private

  def user_params
    params.require(:user).permit(:login_name,:password,
                                 :password_confirmation)
  end

  def is_user_logged
    unless logged_in?
      flash[:danger] = "Prosím prihláste sa."
      redirect_to login
    end
  end

  def am_i_right_user
    @user = find_by_index(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

#OR mapovac nezabudni to dat prec TODO
  def find_by_index(index)
    User.find_by_sql("SELECT * FROM users WHERE id = #{params[:id]}").first
  end
end
