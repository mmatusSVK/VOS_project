class AnswersController < ApplicationController

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

end
