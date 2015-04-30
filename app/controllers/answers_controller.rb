class AnswersController < ApplicationController
  before_action :is_user_logged
  before_action :am_i_right_user
  before_action :am_i_right_topic
  before_action :am_i_right_question
  before_action :set_all_currents

  before_filter :get_user, :get_topic, :get_question

  def get_user
    @login_user = User.find(params[:user_id])
  end

  def get_topic
    @select_topic = Topic.find(params[:topic_id])
  end

  def get_question
    @select_question = Question.find(params[:question_id])
  end

  def index
    @answers = @select_question.answers.where(is_hidden: false)
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = @select_question.answers.build(answer_params)
    if @answer.save
      flash[:success] = "Odpoveď úspešne pridaná"
      redirect_to user_topic_question_answers_path(@login_user, @select_topic, @select_question)
    else
      render 'new'
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(answer_params)
      flash[:success] = "Odpoveď upravená"
      redirect_to user_topic_question_answers_path(@login_user, @current_topic, @select_question)
    else
      render 'edit'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(is_hidden: true)
      flash[:success] = "Odpoveď odstránená"
      redirect_to user_topic_question_answers_path(@login_user, @select_topic, @select_question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer_name, :is_right, :is_hidden)
  end

  def answer_id_from_params
    params.require(:id)
  end

  def set_all_currents
    current_topic(params[:topic_id])
    current_question(params[:question_id])
  end

  def is_user_logged
    unless logged_in?
      flash[:danger] = "Prosím prihláste sa."
      redirect_to login_path
    end
  end

  def am_i_right_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def am_i_right_topic
    @topic = Topic.find(params[:topic_id])
    @user = User.find(@topic.user_id)
    redirect_to(root_url) unless current_user?(@user)
  end

  def am_i_right_question
    @question = Question.find(params[:question_id])
    @topic = Topic.find(@question.topic_id)
    @user = User.find(@topic.user_id)
    redirect_to(root_url) unless current_user?(@user) || @question.is_hidden = true || @topic.is_hidden = true
  end
end
