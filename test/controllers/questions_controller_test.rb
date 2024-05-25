require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def setup
    @user = User.create(login: 'test_user', email: 'test_user@example.com', password: 'password')
    session[:user_id] = @user.id
  end

  test "should redirect to login path if user is not logged in for new action" do
    session[:user_id] = nil
    get :new
    assert_redirected_to login_path_url
  end

  test "should get new if user is logged in for new action" do
    get :new
    assert_response :found
  end
end
