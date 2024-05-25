require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should redirect to login path if user is not logged in" do
    post :create_avatar_file
    assert_response :service_unavailable
  end

  test "should return bad request if no files are received" do
    user = users(:user_one)
    session[:user_id] = user.id
    post :create_avatar_file
    assert_response :bad_request
    assert_equal "No files received.", JSON.parse(response.body)['error']
  end
end
