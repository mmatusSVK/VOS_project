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
    @topic = find_by_index_topic(params[:id])
  end

  def update
    @topic = find_by_index_topic(params[:id])
    if @topic.update_attributes(topic_params)
      flash[:success] = "Téma upravená"
      redirect_to topics_path
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
    if(params[:id] != nil)
      @user = find_by_index_user(Topic.find_by_sql("SELECT * FROM topics WHERE topics.id = #{params[:id]}").first.user_id)
    else
      @user = @current_user
    end
    redirect_to(root_url) unless current_user?(@user)
  end

end
