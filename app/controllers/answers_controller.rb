class AnswersController < ApplicationController
  before_action :set_all_currents;

  before_filter :get_user, :get_topic, :get_question

  def get_user
    @login_user = find_by_index_user(params[:user_id])
  end

  def get_topic
    @select_topic = find_by_index_topic(params[:topic_id])
  end

  def get_question
    @select_question = find_by_index_question(params[:question_id])
  end

  def index
    @answers = Answer.find_by_sql("SELECT a.answer_name, a.is_right, a.question_id, a.id, a.created_at FROM answers a JOIN questions ON questions.id = a.question_id WHERE questions.id = #{@select_question.id}")
  end

  def new
    @answer = Answer.new
  end

  def create
    if add_to_database_answer(@select_question.id, answer_params) #@answer.save
      flash[:success] = "Odpoveď úspešne pridaná"
      redirect_to user_topic_question_answers_path(@login_user, @select_topic, @select_question)
    else
      @answer = []
      render 'new'
    end
  end

  def edit
    @answer = find_by_index_answer(params[:id])
  end

  def update
    if update_in_database_answer(answer_id_from_params, answer_params) #@answer.update_attributes(topic_params)
      flash[:success] = "Odpoveď upravená"
      redirect_to user_topic_question_answers_path(@login_user, @current_topic, @select_question)
    else
      render 'edit'
    end
  end

  def destroy
    if delete_in_database_answer(answer_id_from_params) #@answer.destroy
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
