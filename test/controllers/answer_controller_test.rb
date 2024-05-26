require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  def setup
    @user = users(:user_one)
    session[:user_id] = @user.id
    @question = questions(:question_one)
    @answer = answers(:answer_one)
  end

  test "should not destroy answer if user does not own the answer" do
    session[:user_id] = users(:user_two).id
    assert_no_difference('Answer.count') do
      delete :destroy, params: { id: @answer.id }
    end
    assert_redirected_to my_answers_path
    assert_equal "Ответ не найден или у вас нет прав на его удаление.", flash[:alert]
  end
end
