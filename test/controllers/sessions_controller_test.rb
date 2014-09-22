require '/home/alec/RailsProjects/splitwise/test/test_helper'

class SessionsControllerTest < ActionController::TestCase
  include SessionsHelper, ApplicationHelper
  setup do
    @user = users(:one)
  end

  test 'Unauthed user can get :login' do
    get :login
    assert_response :success
  end

  test 'Authed user redirected to :dashboard' do
    sign_in @user
    get :login
    assert_response :redirect
    assert_redirected_to({controller: :dashboard})
  end

  ## TODO: Test is failing. How to access the current_user method?
  test 'Email and password are correct => session created' do
    post :create, session: { email: @user.email, password: @user.password }
    assert_equal(current_user, @user)
    assert_redirected_to :dashboard
  end

  test 'Unknown email => redirected to /login' do
    
  end

  test 'Invalid password => redirected to /login' do
    
  end
end
