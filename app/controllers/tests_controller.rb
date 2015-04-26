class TestsController < ApplicationController
  #TODO  before_action :is_user_logged
  #  before_action :am_i_right_user
  before_filter :get_user

  def get_user
    @login_user = User.find(params[:user_id])
  end

  def show
    @test = Test.find(params[:id])
    @current_tests = @test.current_tests
    @topic_in_test = nil
  end

  def index
    @tests = @login_user.tests
  end

  def new
    @test = Test.new
    @current_test = CurrentTest.new
    @user_topics = @login_user.topics
  end

  def create
    @current_tests = params[:test][:current_test_attributes]
    @test = @login_user.tests.build(test_params)
    if @test.save
      @current_tests.each do |test|
        @test.current_tests.build(topic_id: test[:topic_id], questions_count: test[:questions_count]).save
      end
      flash[:success] = "Test úspešne pridaný"
      redirect_to user_path(@login_user)
    else
      @test = []
      render 'new'
    end
  end

  def edit
    @test = Test.find(params[:id])
    @current_test = CurrentTest.new

    @user_topics = @login_user.topics
    @current_tests = @test.current_tests
  end

  def update
    @test = Test.find(params[:id])
    @new_current_tests = params[:test][:current_test_attributes]
    if @test.update_attributes(test_params)
      flash[:success] = "Test upravený"
      @test.current_tests.each do |ct|
        ct.destroy
      end
      @new_current_tests.each do |test|
        @test.current_tests.build(topic_id: test[:topic_id], questions_count: test[:questions_count]).save
      end

      redirect_to user_tests_path(@login_user)
    else
      render 'edit'
    end
  end

  def destroy
    @test = Test.find(params[:id])
    if @test.update_attributes(is_hidden: true)
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

    @user_answer = UserAnswer.new
    @topic = nil
    @questions = nil
    @answers = nil
  end

  def make_test_active
    @test = Test.find(params[:test_id])
    @test.update_attributes(starting_date: DateTime.now)

    redirect_to user_tests_path(@login_user)
  end

  def results
#TODO    unless check_duration(@test)
#      flash[:danger] = "Test nebol vykonaný v požadovanom čase!"
#      redirect_to root_path
#    end

    @result = params[:data_from_test]
    @starting_date = Test.find(params[:test_id]).starting_date
    @user_id = DateTime.now.strftime('%s')
    @result.each do |r|
      r[:answer_value].nil? ? r[:answer_value] = false : r[:answer_value] = true
      answer = Answer.find(r[:answer_id])
      answer.is_right == r[:answer_value] ? r[:answer_value] = true : r[:answer_value] = false
      @user_answer = UserAnswer.new(starting_date: @starting_date ,student_id: @user_id, answer_value: r[:answer_value], test_id: r[:test_id], answer_id: r[:answer_id]).save
    end
    redirect_to root_path
  end

  def concrete_test
    @test = Test.find(params[:test_id])
    @starting_date = params[:starting_date]
    @all_answers = UserAnswer.where(test_id: @test.id, starting_date: @starting_date)

    @all_questions = []
    @all_topics = []
    @all_topics_answers = {}
    @all_questions_answers = {}

    @all_answers.each do |aa|
      answer = Answer.find(aa.answer_id)
      @all_questions << answer.question_id
    end
    @all_questions = Question.where(id: @all_questions)

    @all_questions.each do |val|
      @all_topics << val.topic_id
    end
    @all_topics = Topic.where(id: @all_topics)

    @all_topics.each do |at|
      at.questions.each do |at_question|
        at_question.answers.each do |at_answer|
          at_answer.user_answers.each do |at_user_answer|
            if at_user_answer.starting_date == @starting_date
              @all_questions_answers[at_question.id].nil? ? @all_questions_answers[at_question.id] = [] : true
              @all_questions_answers[at_question.id] << at_user_answer.id

              @all_topics_answers[at.id].nil? ? @all_topics_answers[at.id] = [] : true
              @all_topics_answers[at.id] << at_user_answer.id
            end
          end
        end
      end
    end

    @all_topics_answers.each do |key, val|
      @all_topics_answers[key] = UserAnswer.where(id: val)
    end
    @all_questions_answers.each do |key, val|
      @all_questions_answers[key] = UserAnswer.where(id: val)
    end

  end

  private

  def test_params
    params.require(:test).permit(:test_name, :duration, :starting_date)
  end

end
