require '/home/alec/RailsProjects/splitwise/test/test_helper'

class UsersControllerTest < ActionController::TestCase
  include SessionsHelper

  setup do
    @user = users(:one)
    @test_fname = 'Abcdefg'
    @test_lname = 'Hijklmnop'
    @test_email = 'aaa@bbb.cc'
    @test_password = 'testing1'
  end

  test "authed user should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test 'unauthed user cannot get index' do
    get :index
    assert_response :redirect
    assert_redirected_to 'http://test.host/login'
  end

  test "Authed user should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test 'Unauthed user cannot get new' do
    get :new
    assert_response :redirect
  end

  test 'authed user can create user' do
    sign_in @user
    assert_difference('User.count') do
      post :create, user: { email: @user.email, fname: @user.fname, lname: @user.lname, 
                            password: @test_password, password_confirmation: @test_password }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test 'anon user cannot create' do
    assert_no_difference('User.count') do
      post :create, user: { email: @user.email, fname: @user.fname, lname: @user.lname, 
                            password: @test_password, password_confirmation: @test_password }
    end

    assert_redirected_to 'http://test.host/login'
  end

  test 'invalid email => redirects to user' do
    sign_in @user
    assert_no_difference('User.count') do
      post :create, user: { email: 'blahblah', fname: @user.fname, lname: @user.lname, password: @user.password }
    end
  end

  test "should show user" do
    sign_in @user
    get :show, id: @user
    assert_response :success
  end

  test 'authed user gets edit' do
    sign_in @user
    get :edit, id: @user
    assert_response :success
  end

  test 'anon user cannot get edit' do
    get :edit, id: @user
    assert_response :redirect
    assert_redirected_to 'http://test.host/login'
  end

  test "should update user" do
    sign_in @user
    patch :update, id: @user.id, user: { email: @user.email, fname: @user.fname, 
              lname: @user.lname, password: @test_password + 'aaa', 
              password_confirmation: @test_password + 'aaa'  }
    assert_redirected_to user_path(assigns(:user))
  end

  test 'anon user cannot update' do
    patch :update, id: @user.id, user: { email: @user.email, fname: @user.fname, 
              lname: @user.lname, password: @test_password + 'aaa', 
              password_confirmation: @test_password + 'aaa'  }
    assert_redirected_to 'http://test.host/login'
  end

  test 'authed user can destroy' do
    sign_in @user
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test 'anon user cannot destroy' do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end

    assert_redirected_to 'http://test.host/login'
  end
end
