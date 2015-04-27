class TopicsController < ApplicationController
  before_action :is_user_logged,    only: [:show, :index, :new, :update]
  before_action :am_i_right_user,   only: [:show, :index, :new, :update]

  before_filter :get_user

  def get_user
    @login_user = User.find(params[:user_id])
  end

  def index
    @topic = @current_user.topics
#    @counts_of_questions = find_all_question_counts
  end

  def show
    @topic = Topic.find(params[:id])
    redirect_to user_topic_questions_path(@login_user, @topic)
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      flash[:success] = "Téma upravená"
      redirect_to user_topics_path(@login_user)
    else
      render 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:success] = "Téma odstránená"
      redirect_to user_topics_path(@login_user)
    end
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:success] = "Téma úspešne pridaná"
      redirect_to user_topics_path(@login_user)
    else
      @topic = []
      render 'new'
    end
  end


  private

  def topic_id_from_params
    params.require(:id)
  end

  def topic_params
    params.require(:topic).permit(:topic_name, :information)
  end

  def is_user_logged
    unless logged_in?
      flash[:danger] = "Prosím prihláste sa."
      redirect_to login_path
    end
  end

  def am_i_right_user
     if(params[:id] != nil)
        @user = User.find(Topic.find(params[:id]).user_id)
      else
        @user = @current_user
     end
    redirect_to(root_url) unless current_user?(@user)
  end

end
