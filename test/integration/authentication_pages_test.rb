require_relative '../test_helper'

class AuthenticationPagesTest < ActionDispatch::IntegrationTest
  test 'get login page' do
    get '/login'
    assert_response :success
  end
end
