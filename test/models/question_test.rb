require 'test_helper'
require "minitest/autorun"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

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
