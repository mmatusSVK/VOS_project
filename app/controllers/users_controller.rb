class UsersController < ApplicationController
  before_action :is_user_logged, only: [:show, :analyzed_test, :edit, :update]
  before_action :am_i_right_user,   only: [:show, :analyzed_tests, :edit, :update]
  before_filter :set_user, only: :analyzed_tests

  def set_user
    @login_user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:id])
    @topic = @user.topics
    @topic.each do |t|
      if t.is_hidden == true && t.user_answers.count == 0
        t.destroy
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    unless @user.authenticate(params[:current_password])
      flash[:danger] = "Staré heslo sa nezhoduje"
      render 'edit'
      return
    end
    if @user.update_attributes(user_params)
      flash[:success] = "Heslo zmenené"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def analyzed_tests
    @tests = @login_user.tests

    @user_answers = []
    @tests.each do |t|
      @user_answers << t.user_answers
    end

    @one_test_data = {}
    @user_answers.each do |user_a|
      user_a.each do |current_a|
          @one_test_data[current_a.starting_date] = current_a
        end
    end

  end

  private

  def user_params
    params.require(:user).permit(:login_name, :password, :password_confirmation)
  end

  def is_user_logged
    unless logged_in?
      flash[:danger] = "Prosím prihláste sa."
      redirect_to login_path
    end
  end

  def am_i_right_user
    params[:id].nil? ? @user = User.find(params[:user_id]) : @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


end
