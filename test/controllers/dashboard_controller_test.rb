require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  include SessionsHelper
  setup do
    @user = users(:one)
  end

  test 'Authed user should get :index' do
    sign_in @user
    get :index
    assert_response :success
  end

  test 'Unauthed user cannot get :index' do
    get :index
    assert_response :redirect
    assert_redirected_to({controller: :sessions, action: :login})
  end

  # TODO: Figure out a way to make the @tabs attribute accessible here. Jack the attr_reader
  #       during test execution??
  # test '@tabs is set', :skip do
  #   @tab = tabs(:one)
  #   sign_in @user
  #   get :index
  # end
end
