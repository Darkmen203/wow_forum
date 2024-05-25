require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
    setup do
        @user = users(:user_one)
      end
    
      test "current_user should return the user when logged in" do
        session[:user_id] = @user.id
        assert_equal @user, @controller.current_user
      end
    
      test "current_user should return nil when not logged in" do
        session[:user_id] = nil
        assert_nil @controller.current_user
      end
end
