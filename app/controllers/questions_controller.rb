class QuestionsController < ApplicationController
  before_action :set_current_topic
  before_action :is_user_logged
  before_action :am_i_right_user

  before_filter :get_user, :get_topic

  def get_user
    @login_user = User.find(params[:user_id])
  end

  def get_topic
    @select_topic = Topic.find(params[:topic_id])
  end

  def index
    @question = @select_topic.questions
#    @count_of_question = select_count_of_questions(@select_topic.id).first["count"]
  end

  def show
    @question = Question.find(params[:id])
    redirect_to user_topic_question_answers_path(@login_user, @select_topic, @question)
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "Otázka upravená"
      redirect_to user_topic_questions_path(@login_user, @select_topic)
    else
      render 'edit'
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = @select_topic.questions.build(question_params)
    if @question.save
      flash[:success] = "Otázka úspešne pridaná"
      redirect_to user_topic_questions_path(@login_user, @select_topic)
    else
      @question = []
      render 'new'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:success] = "Otázka odstránená"
      redirect_to user_topic_questions_path(@login_user, @select_topic)
    end
  end

  private

  def question_id_from_params
    params.require(:id)
  end

  def set_current_topic
    current_topic(params[:topic_id])
  end

  def question_params
    params.require(:question).permit(:question_name)
  end

  def is_user_logged
    unless logged_in?
      flash[:danger] = "Prosím prihláste sa."
      redirect_to login_path
    end
  end

  def am_i_right_user
    #TODO dorobit kontrolu pri otazkach
  end

end
