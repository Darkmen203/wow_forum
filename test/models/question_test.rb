require 'test_helper'
require "minitest/autorun"

class QuestionTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:user_one)
    @question = Question.new(title: "Test Title", body: "Test Body", user: @user)
  end

  test "should be valid" do
    assert @question.valid?
  end

  test "title should be present" do
    @question.title = "   "
    assert_not @question.valid?
  end

  test "body should be present" do
    @question.body = "   "
    assert_not @question.valid?
  end

  test "user should be present" do
    @question.user = nil
    assert_not @question.valid?
  end

  test "should have many answers" do
    assert_respond_to @question, :answers
  end

  describe Question do
    it 'cannot have an empty title' do
      question = Question.create(body: 'some text')
      _(question.valid?).must_equal false
    end

    it 'cannot have an empty body' do
      question = Question.create(title: 'some text')
      _(question.valid?).must_equal false
    end
  end


end
