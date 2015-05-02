class TopicsController < ApplicationController
  before_action :is_user_logged
  before_action :am_i_right_user

  before_filter :get_user

  def get_user
    @login_user = User.find(params[:user_id])
  end

  def index
    @topic = @current_user.topics.where(is_hidden: false)
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
    @questions_ids = []
    @topic.questions.each do |q|
      @questions_ids << q.id
    end
    if Answer.where(question_id: @questions_ids).update_all(is_hidden: true) && Question.where(topic_id: @topic.id ).update_all(is_hidden: true) && @topic.update_attributes(is_hidden: true)
      @topic.current_tests.delete_all
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
      render 'new'
    end
  end


  private

  def topic_id_from_params
    params.require(:id)
  end

  def topic_params
    params.require(:topic).permit(:topic_name, :information, :is_hidden)
  end

  def is_user_logged
    unless logged_in?
      flash[:danger] = "Prosím prihláste sa."
      redirect_to login_path
    end
  end

  def am_i_right_user
     if(params[:id] != nil)
        @topic = Topic.find(params[:id])
        @user = User.find(@topic.user_id)
      else
        @user = @current_user
     end
    redirect_to(root_url) unless current_user?(@user)
  end

end
