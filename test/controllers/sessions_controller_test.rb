require '/home/alec/RailsProjects/splitwise/test/test_helper'

class SessionsControllerTest < ActionController::TestCase
  include SessionsHelper, ApplicationHelper
  setup do
    @user = users(:one)
    @password = 'testing1'
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

  test 'Email and password are correct => session created' do
    post :create, session: { email: @user.email, password: @password }
    assert_equal(@user, current_user)
    assert_redirected_to({controller: :dashboard})
  end

  test 'Unknown email => redirected to /login' do
    post :create, session: { email: 'notrealuser@notreal.com', password: @password }
    assert_nil current_user
    assert_equal('Invalid email or password', flash[:error])
  end

  test 'Invalid password => redirected to /login' do
    post :create, session: { email: @user.email, password: 'wrongpw'}
    assert_nil current_user
    assert_equal('Invalid email or password', flash[:error])
  end
end
