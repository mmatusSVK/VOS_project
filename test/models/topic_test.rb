require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @topic = Topic.new(topic_name: "ADM", information: "bla bla bla", user_id: 1)
  end

  test "should be valid" do
    assert @topic.valid?
  end

  test "user_id should bew present" do
    @topic.user_id = ''
    assert_not @topic.valid?
  end

  test "topic_name should be present" do
    @topic.topic_name = "     "
    assert_not @topic.valid?
  end

  test "information should be present" do
    @topic.information = "     "
    assert_not @topic.valid?
  end

  test "topic_name should not be too long" do
    @topic.topic_name = "a" * 51
    assert_not @topic.valid?
  end

  test "information should not be too long" do
    @topic.information = "a" * 401
    assert_not @topic.valid?
  end

  test "topic_name should have a minimum length" do
    @topic.topic_name = ""
    assert_not @topic.valid?
  end

  test "information should have a minimum length" do
    @topic.information = ""
    assert_not @topic.valid?
  end


end
