require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_one)
    @question = questions(:question_one)
    @answer = Answer.new(body: "Test answer", user: @user, question: @question)
  end

  test "should be valid" do
    assert @answer.valid?
  end

  test "body should be present" do
    @answer.body = "   "
    assert @answer.valid?
  end

  test "user should be present" do
    @answer.user = nil
    assert_not @answer.valid?
  end

  test "question should be present" do
    @answer.question = nil
    assert_not @answer.valid?
  end
end

