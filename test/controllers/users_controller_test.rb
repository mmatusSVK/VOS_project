require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user       = users(:matus)
    @other_user = users(:kebab)
  end

  test "should redirect show when not logged in" do
    get :show, id: @user
    assert_redirected_to login_url
  end


  test "should redirect show when logged in as wrong user" do
    log_in_as(@other_user)
    get :show, id: @user
#    assert flash.empty?
    assert_redirected_to root_url
  end


end
