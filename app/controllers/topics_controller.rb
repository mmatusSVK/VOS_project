class TopicsController < ApplicationController
  before_action :is_user_logged,    only: [:show, :index, :new, :update]
  before_action :am_i_right_user,   only: [:show, :index, :new, :update]

  before_filter :get_user

  def get_user
    @login_user = find_by_index_user(params[:user_id])
  end

  def index
    @topic = Topic.find_by_sql("SELECT t.id, t.topic_name, t.user_id, t.information, t.created_at FROM topics t JOIN users ON users.id = t.user_id WHERE users.id = #{@login_user.id}") #TODO otazka
    @counts_of_questions = find_all_question_counts
  end

  def show
    @topic = Topic.find_by_sql("SELECT * FROM topics WHERE topics.id = #{params[:id]}").first
    redirect_to user_topic_questions_path(@login_user, @topic)
  end

  def edit
    @topic = find_by_index_topic(params[:id])
  end

  def update
    if update_in_database_topic(topic_id_from_params, topic_params) #@topic.update_attributes(topic_params)
      flash[:success] = "Téma upravená"
      redirect_to user_topics_path(@login_user)
    else
      render 'edit'
    end
  end

  def destroy
    #@topic = Topic.find_by(id: params[:id])  #TODO zobrazit po DB odovzdani
    if delete_in_database_topic(topic_id_from_params) #@topic.destroy
      flash[:success] = "Téma odstránená"
      redirect_to user_topics_path(@login_user)
    end

    #TODO else??
  end

  def new
    @topic = Topic.new
  end

  def create
    #@topic = current_user.topics.build(topic_params) #TODO zobrazit po DB odovzdani
    if add_to_database_topic(@login_user.id, topic_params) #@topic.save
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
        @user = find_by_index_user(Topic.find_by_sql("SELECT * FROM topics WHERE topics.id = #{params[:id]}").first.user_id)
      else
        @user = @current_user
     end
    redirect_to(root_url) unless current_user?(@user)
  end

end
