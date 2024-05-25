require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  self.use_transactional_tests = true

  # test "should redirect to GitHub for authentication" do
  #   get github_auth_url
  #   assert_response :redirect
  #   assert_match /https:\/\/github\.com\/login\/oauth\/authorize/, @response.headers['Location']
  # end

  # test "should handle GitHub callback and sign in user" do
  #   stub_github_oauth

  #   get github_callback_url, params: { code: 'fake_code' }
  #   assert_response :redirect
  #   assert_redirected_to root_path
  #   assert_not_nil session[:user_id]
  #   assert_equal 'Signed in!', flash[:notice]
  # end

  # test "should sign out user" do
  #   delete logout_url
  #   assert_response :redirect
  #   assert_redirected_to root_path
  #   assert_nil session[:user_id]
  #   assert_equal 'Signed out!', flash[:notice]
  # end

  private

  def stub_github_oauth
    # Stub GitHub token request
    stub_request(:post, "https://github.com/login/oauth/access_token")
      .with(
        body: { client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET'], code: 'fake_code' },
        headers: { 'Accept' => 'application/json' }
      )
      .to_return(
        body: { access_token: 'fake_access_token' }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    # Stub GitHub user info request
    stub_request(:get, "https://api.github.com/user")
      .with(headers: { 'Authorization' => 'token fake_access_token', 'User-Agent' => 'RailsApp' })
      .to_return(
        body: { id: 1, login: 'fakeuser', name: 'Fake User', avatar_url: 'https://example.com/avatar.png' }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    # Stub GitHub emails request
    stub_request(:get, "https://api.github.com/user/emails")
      .with(headers: { 'Authorization' => 'token fake_access_token', 'User-Agent' => 'RailsApp' })
      .to_return(
        body: [{ email: 'fakeuser@example.com', primary: true, verified: true }].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end
end

