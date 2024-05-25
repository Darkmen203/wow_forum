require 'test_helper'

class AuthsControllerTest < ActionController::TestCase
    test "should create user if login is unique and passwords match" do
        post :create, params: { login: 'new_user', email: 'new_user@example.com', password: 'password', password_confirmation: 'password' }
        assert_redirected_to root_path
        assert_equal 'new_user', session[:name]
        assert_equal '/skull-solid.svg', session[:avatar_url]
        assert session[:user_id].present?
    end

    test "should not create user if login is not unique" do
        user = User.create(login: 'existing_user', email: 'existing_user@example.com', password: 'password')
        post :create, params: { login: 'existing_user', email: 'new_user@example.com', password: 'password', password_confirmation: 'password' }
        assert_redirected_to root_path
        assert_nil flash[:alert]
    end
    

  test "should not create user if passwords do not match" do
    post :create, params: { login: 'new_user', email: 'new_user@example.com', password: 'password', password_confirmation: 'different_password' }
    assert_redirected_to register_path_url
    assert_equal 'Пароли не совпадают', flash[:alert]
    assert_nil session[:user_id]
  end

  test "should sign in user if credentials are correct" do
    user = User.create(login: 'existing_user', email: 'existing_user@example.com', password: 'password')
    post :sign, params: {  password: 'password', email: 'existing_user@example.com', }
    assert_redirected_to root_path + 'auth/login'
    assert_nil session[:user_id]
  end

  test "should not sign in user if credentials are incorrect" do
    User.create(login: 'existing_user', email: 'existing_user@example.com', password: 'password')
    post :sign, params: { email: 'wrong_email@example.com', password: 'wrong_password' }
    assert_redirected_to login_path_url
    assert_equal 'Пароль или почта не верны', flash[:alert]
    assert_nil session[:user_id]
  end
end
