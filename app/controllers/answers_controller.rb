class AnswersController < ApplicationController
  before_action :set_all_currents;
#TODO  before_action :is_user_logged
#  before_action :am_i_right_user

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
    @answers = @select_question.answers
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
      @answer = []
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
    if @answer.destroy
      flash[:success] = "Odpoveď odstránená"
      redirect_to user_topic_question_answers_path(@login_user, @select_topic, @select_question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer_name, :is_right)
  end

  def answer_id_from_params
    params.require(:id)
  end

  def set_all_currents
    current_topic(params[:topic_id])
    current_question(params[:question_id])
  end
end
