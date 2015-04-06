class QuestionsController < ApplicationController
  before_action :set_current_topic
  before_action :is_user_logged
  before_action :am_i_right_user

  before_filter :get_user, :get_topic

  def get_user
    @login_user = find_by_index_user(params[:user_id])
  end

  def get_topic
    @select_topic = find_by_index_topic(params[:topic_id])
  end

  def index
    @question = Question.find_by_sql("SELECT q.id, q.question_name, q.topic_id, q.created_at FROM questions q JOIN topics ON topics.id = q.topic_id WHERE topics.id = #{@select_topic.id}")
    @count_of_question = select_count_of_questions(@select_topic.id).first["count"]
  end

  def show
    @question = find_by_index_question(params[:id])
    redirect_to user_topic_question_answers_path(@login_user, @select_topic, @question)
  end

  def edit
    @question = find_by_index_question(params[:id])
  end

  def update
    if update_in_database_question(question_id_from_params, question_params) #@question.update_attributes(topic_params)
      flash[:success] = "Otázka upravená"
      redirect_to user_topic_questions_path(@login_user, @current_topic)
    else
      render 'edit'
    end
  end

  def new
    @question = Question.new
  end

  def create
    if add_to_database_question(@current_topic.id, question_params) #@question.save
      flash[:success] = "Otázka úspešne pridaná"
      redirect_to user_topic_questions_path(@login_user, @current_topic)
    else
      @question = []
      render 'new'
    end
  end

  def destroy
    if delete_in_database_question(question_id_from_params) #@question.destroy
      flash[:success] = "Otázka odstránená"
      redirect_to user_topic_questions_path(@login_user, @current_topic)
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
