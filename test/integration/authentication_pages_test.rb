require_relative '../test_helper'

class AuthenticationPagesTest < ActionDispatch::IntegrationTest
  
  test 'get login page' do
    get '/login'
    assert_response :success
  end

  test 'session created correctly' do
    post_via_redirect '/create', email: users(:one).email, password: users(:one).password
    assert_response :success
    assert_equal '/dashboard', path
    assert_equal "Welcome, #{users(:one).fname}", flash[:notice]
  end

  test 'invalid email => NOT logged in' do
    post '/create', post: {email: 'blah', password: users(:one).password}
    assert_response :failure
    assert_equal '/login', path
    assert_equal 'Invalid password', flash[:notice]
  end
end
