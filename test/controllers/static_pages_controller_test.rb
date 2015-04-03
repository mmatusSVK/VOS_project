require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  test "should get rootPage" do
    get :rootPage
    assert_response :success
  end
end
