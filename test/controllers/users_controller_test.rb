require '/home/alec/RailsProjects/splitwise/test/test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @test_fname = 'Abcdefg'
    @test_lname = 'Hijklmnop'
    @test_email = 'aaa@bbb.cc'
    @test_password = 'testing1'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: @user.email, fname: @user.fname, lname: @user.lname, 
                            password: @test_password, password_confirmation: @test_password }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test 'invalid email => redirects to user' do
    assert_no_difference('User.count') do
      post :create, user: { email: 'blahblah', fname: @user.fname, lname: @user.lname, password: @user.password }
    end
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user.id, user: { email: @user.email, fname: @user.fname, 
              lname: @user.lname, password: @test_password + 'aaa', 
              password_confirmation: @test_password + 'aaa'  }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
