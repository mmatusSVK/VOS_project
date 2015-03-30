class TopicsController < ApplicationController
  before_action :is_user_logged, only: [:show]
  before_action :am_i_right_user,   only: [:show]

  def index
    @topic = Topic.find_by_sql("SELECT * FROM topics JOIN users ON users.id = topics.user_id WHERE users.id = #{current_user.id}")
  end

  def show
    @topic = Topic.find_by_sql("SELECT * FROM topics WHERE topics.id = #{params[:id]}").first
  end

  def update
    # code here
  end

  def new
    @topic = Topic.new
  end



  private

  def is_user_logged
    unless logged_in?
      flash.now[:danger] = "Prosím prihláste sa."
      redirect_to login_path
    end
  end

  def am_i_right_user
    @user = find_by_index(Topic.find_by_sql("SELECT * FROM topics WHERE topics.id = #{params[:id]}").first.user_id)
    redirect_to(root_url) unless current_user?(@user)
  end

end
