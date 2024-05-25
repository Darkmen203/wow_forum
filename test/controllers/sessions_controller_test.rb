require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should redirect to GitHub auth URL" do
    get :github_auth
    assert_redirected_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_ID']}&redirect_uri=http://localhost:3000/auth/github/callback&scope=user,repo"
  end

  test "should sign out user" do
    session[:user_id] = 'test_user_id'
    get :destroy
    assert_nil session[:user_id]
    assert_redirected_to root_path
    assert_equal 'Signed out!', flash[:notice]
  end
end
