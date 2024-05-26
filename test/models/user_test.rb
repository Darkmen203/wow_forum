require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(provider: "test_provider", login: "test_login", token: "test_token")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "provider should be present" do
    @user.provider = "   "
    assert_not @user.valid?
  end

  test "login should be present" do
    @user.login = "   "
    assert_not @user.valid?
  end

  test "token should be present" do
    @user.token = "   "
    assert_not @user.valid?
  end

  test "should have many questions" do
    assert_respond_to @user, :questions
  end

  test "should have many answers" do
    assert_respond_to @user, :answers
  end
end
