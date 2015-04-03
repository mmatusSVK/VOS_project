class QuestionsController < ApplicationController
  before_action :set_current_topic

  before_filter :get_user, :get_topic

  def get_user
    @login_user = find_by_index_user(params[:user_id])
  end

  def get_topic
    @select_topic = find_by_index_topic(params[:topic_id])
  end

  def index
    @question = Question.find_by_sql("SELECT q.id, q.question_name, q.topic_id FROM questions q JOIN topics ON topics.id = q.topic_id WHERE topics.id = #{@select_topic.id}")
  end

  def new

  end

  def create

  end

  private

  def set_current_topic
    current_topic(params[:topic_id])
  end

end
