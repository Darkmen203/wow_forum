require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  def setup
    @user = User.create(login: 'test_user', email: 'test_user@example.com', password: 'password')
    session[:user_id] = @user.id 
  end

  test "should redirect to login path if user is not logged in for show action" do
    session[:user_id] = nil
    get :show
    assert_redirected_to login_path_url
  end

  test "should load user profile for show action" do
    get :show
    assert_response :found
  end

  test "should redirect to login path if user is not logged in for my_questions action" do
    session[:user_id] = nil 
    get :my_questions
    assert_redirected_to login_path_url
  end

  test "should load user's questions for my_questions action" do
    get :my_questions, session: { user_id: @user.id }
    assert_response :found
  end

  test "should redirect to login path if user is not logged in for my_answers action" do
    session[:user_id] = nil 
    get :my_answers
    assert_redirected_to login_path_url
  end

  test "should load user's answers for my_answers action" do
    get :my_answers, session: { user_id: @user.id } 
    assert_response :found
  end

  test "should redirect to login path if user is not logged in for settings action" do
    session[:user_id] = nil 
    get :settings
    assert_redirected_to login_path_url
  end

  test "should load settings page if user is logged in for settings action" do
    get :settings, session: { user_id: @user.id } 
    assert_response :found
  end
end
