class TopicsController < ApplicationController
  before_action :is_user_logged,    only: [:show, :index, :new, :update]
  before_action :am_i_right_user,   only: [:show, :index, :new, :update]

  def index
    @topic = current_user.topics
    #@topic = Topic.find_by_sql("SELECT * FROM topics JOIN users ON users.id = topics.user_id WHERE users.id = #{current_user.id}") #TODO otazka
  end

  def show
    @topic = Topic.find_by_sql("SELECT * FROM topics WHERE topics.id = #{params[:id]}").first
  end

  def edit
    @topic = find_by_index(params[:id])
  end

  def update
    @topic = find_by_index(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy

  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params) #TODO create zaznam
    if @topic.save
      flash[:success] = "Téma úspešne pridaná"
      redirect_to topics_path
    else
      @topic = []
      render 'new'
    end
  end




  
  private

  def topic_params
    params.require(:topic).permit(:topic_name, :information, :user_id)
  end

  def is_user_logged
    unless logged_in?
      flash[:danger] = "Prosím prihláste sa."
      redirect_to login_path
    end
  end

  def am_i_right_user
    @user = find_by_index(Topic.find_by_sql("SELECT * FROM topics WHERE topics.id = #{params[:id]}").first.user_id)
    redirect_to(root_url) unless current_user?(@user)
  end

end
