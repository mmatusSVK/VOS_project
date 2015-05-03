class TestsController < ApplicationController
  before_action :is_user_logged, except: [:active_test, :results]
  before_action :am_i_right_user, except: [:active_test, :results]

  before_filter :get_user

  def get_user
    @login_user = User.find(params[:user_id])
  end

  def show
    @test = Test.find(params[:id])
    @current_tests = @test.current_tests
    @topic_in_test = @test.topics
  end

  def index
    @tests = @login_user.tests
    @tests.each do |t|
      if(t.current_tests.count == 0)
        t.update_attributes(is_hidden: true)
      end
      if(t.is_hidden == true && t.user_answers.count == 0)
        t.destroy
      end
    end
    @tests = @login_user.tests.where(is_hidden: false)
  end

  def new
    @test = Test.new
    @current_tests= CurrentTest.new
    @user_topics = []
    @login_user.topics.each do |t|
      if(t.questions.count > 0  && t.is_hidden == false)
        t.questions.each do |q|
          if q.answers.count > 0
            @user_topics << t
            break
          end
        end
      end
    end
  end

  def create
    @current_tests = params[:test][:current_tests_attributes]
    @test = @login_user.tests.build(test_params)
    if @test.save
      ActiveRecord::Base.transaction do
        @current_tests.each do |test|
          @test.current_tests.build(topic_id: test[:topic_id], questions_count: test[:questions_count]).save
        end
      end
      flash[:success] = "Test úspešne pridaný"
      redirect_to user_tests_path(@login_user)
    else
      @current_test = CurrentTest.new
      @user_topics = @login_user.topics
      render 'new'
    end
  end

  def edit
    @test = Test.find(params[:id])
    @current_tests = CurrentTest.new
    @user_topics = @login_user.topics
    @current_tests_all = @test.current_tests
  end

  def update
    @test = Test.find(params[:id])
    @current_tests = CurrentTest.new
    @user_topics = @login_user.topics
    @current_tests_all = @test.current_tests

    @new_current_tests = params[:test][:current_tests_attributes]
    if @test.update_attributes(test_params)
      flash[:success] = "Test upravený"
      ActiveRecord::Base.transaction do
        @test.current_tests.each do |ct|
          ct.destroy
        end
        @new_current_tests.each do |test|
          @test.current_tests.build(topic_id: test[:topic_id], questions_count: test[:questions_count]).save
        end
      end
      redirect_to user_tests_path(@login_user)
    else
      render 'edit'
    end
  end

  def destroy
    @test = Test.find(params[:id])
    if @test.update_attributes(is_hidden: true)
      @test.current_tests.delete_all
      flash[:success] = "Test odstránený"
      redirect_to user_tests_path(@login_user)
    end
  end

  def active_test
    @test = Test.find(params[:test_id])
    unless check_duration(@test)
      flash[:danger] = "Čas vypršal!"
      redirect_to root_path
    end
    @current_tests = @test.current_tests
    @current_tests.shuffle

    @topic = []
    @questions = {}
    @answers = {}
    @current_tests.each do |ct|
      @questions[ct.topic_id].nil? ? @questions[ct.topic_id] = choose_random_questions(ct.topic_id, ct.questions_count) : true
      @questions[ct.topic_id].each do |q|
        @answers[q.id].nil? ? @answers[q.id] = q.answers : true
      end
    end

    @user_answer = UserAnswer.new
  end

  def make_test_active
    @test = Test.find(params[:test_id])
    @test.update_attributes(starting_date: DateTime.now)

    redirect_to user_tests_path(@login_user)
  end

  def results
    @test = Test.find(params[:test_id])
    unless check_duration(@test)
      flash[:danger] = "Test nebol vykonaný v požadovanom čase!"
      redirect_to root_path and return
    end
    @result = params[:data_from_test]
    @starting_date = Test.find(params[:test_id]).starting_date
    @user_id = DateTime.now.strftime('%s')
    @result.each do |r|
      r[:answer_value].nil? ? r[:answer_value] = false : r[:answer_value] = true
      answer = Answer.find(r[:answer_id])
      answer.is_right == r[:answer_value] ? r[:answer_value] = true : r[:answer_value] = false
      @user_answer = UserAnswer.new(starting_date: @starting_date ,student_id: @user_id, answer_value: r[:answer_value], old_test_name: @test.test_name,
                                    test_id: r[:test_id], question_id: r[:question_id], topic_id: r[:topic_id]).save
    end
    redirect_to root_path
  end

  def concrete_test
    @test = Test.find(params[:test_id])
    @starting_date = params[:starting_date]
    @show_q = params[:show_q]
    @show_q == 'q' ? set_question_analyzation(true) : set_question_analyzation(false)
    @all_answers = UserAnswer.where(test_id: @test.id, starting_date: @starting_date)

    @all_questions = []
    @all_topics = []
    @all_topics_answers = {}
    @all_questions_answers = {}

    @all_answers.each do |aa|
      @all_questions << aa.question_id
      @all_questions_answers[aa.question_id] = nil
      @all_topics << aa.topic_id
      @all_topics_answers[aa.topic_id] = nil
    end
    @all_questions = Question.where(id: @all_questions)
    @all_topics = Topic.where(id: @all_topics)


    @all_topics_answers.each do |key, val|
      @all_topics_answers[key] = @all_answers.where(topic_id: key)
    end
    @all_questions_answers.each do |key, val|
      @all_questions_answers[key] = @all_answers.where(question_id: key)
    end
  end

  private

  def test_params
    params.require(:test).permit(:test_name, :duration, :starting_date, :current_tests_attributes, :is_hidden)
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

end
