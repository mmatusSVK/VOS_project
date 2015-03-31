class UsersController < ApplicationController
  before_action :is_user_logged, only: [:show]
  before_action :am_i_right_user,   only: [:show]

  def show
    @user = find_by_index(params[:id])

    #@topic = Topic.find_by_sql("SELECT * FROM topics JOIN users ON users.id = topics.user_id WHERE topics.user_id = #{params[:id]}")
    @topic = @user.topics
  end

  private

  def user_params
    params.require(:user).permit(:login_name, :password, :password_confirmation)
  end

  def is_user_logged
    unless logged_in?
      flash[:danger] = "Prosím prihláste sa."
      redirect_to login_path
    end
  end

  def am_i_right_user
    @user = find_by_index(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


end
