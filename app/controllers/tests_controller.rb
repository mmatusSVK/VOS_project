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
    params[:test][:starting_date] = DateTime.now

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
    if @test.destroy
      flash[:success] = "Test odstránený"
      redirect_to user_tests_path(@login_user)
    end
  end

  def active_test
    @test = Test.find(params[:test_id])
    @current_tests = @test.current_tests
    @current_tests.shuffle

    @topic = nil
    @questions = nil
    @answers = nil
  end



  def results

  end

  private

  def test_params
    params.require(:test).permit(:test_name, :duration, :starting_date)
  end
end
