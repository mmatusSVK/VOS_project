require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(login_name: "Example User",password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be uniq" do
    duplicate_user = @user.dup
    duplicate_user.login_name = @user.login_name.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

end
