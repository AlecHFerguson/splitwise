require 'test_helper'

class TabsControllerTest < ActionController::TestCase
  include SessionsHelper
  setup do
    @user = users(:one)

    @test_name = 'Test tab name'
    @test_description = 'Test description'
  end

  test 'For authed user, :index redirects to :dashboard' do
    sign_in @user
    get :index
    assert_redirected_to({controller: :dashboard, action: :index})
  end

  test 'For unauthed user, :index redirects to /login' do
    get :index
    assert_redirected_to '/login'
  end

  test 'Authed user can get :new' do
    sign_in @user
    get :new
    assert_response :success
    # TODO: What does ::assigns mean?
    # assert_not_nil assigns(:tabs)
  end

  test 'Anon user cannot get :new' do
    get :new
    assert_redirected_to '/login'
  end

  test 'Authed user can create tab with valid params' do
    sign_in @user
    assert_difference('Tab.count') do
      post :create, tab: { name: @test_name, description: @test_description,
                           user_id: @user.id
                          }
    end
    tab_in_db = Tab.last
    assert_equal tab_in_db.name, @test_name
    assert_equal tab_in_db.description, @test_description
    assert_equal tab_in_db.user_id, @user.id
  end

  test 'Authed user can create tab with participants saved' do
    user2 = users(:two)
    user3 = users(:three)
    
    sign_in @user
    assert_difference('Participant.count', 2) do
      post :create, tab: { name: 'blah', description: 'blah', user_id: @user.id,
                           splitters: [user2.id, user3.id]
                        }
    end

    new_tab = Tab.find_by_name('blah')
    participants = Participant.where(tab_id: new_tab.id)
    assert_equal Participant.where(tab_id: new_tab.id, user_id: user2.id).count, 1
    assert_equal Participant.where(tab_id: new_tab.id, user_id: user3.id).count, 1
  end

  test 'Anon user cannot create tab' do
    assert_no_difference('Tab.count') do
      post :create, tab: { name: @test_name, description: @test_description,
                           user_id: @user.id
                          }
    end
  end

  test 'Authed user can update tab' do
    tab = tabs(:one)
    new_name, new_description = 'new name', 'new description'

    sign_in @user
    patch :update, id: tab.id, tab: { name: new_name, description: new_description,
                                      user_id: @user.id, splitters: []
                                    }

    tab_in_db = Tab.find_by_id(tab.id)
    assert_equal tab_in_db.name, new_name
    assert_equal tab_in_db.description, new_description
  end

  test 'Authed user can update splitters properly' do
    assert_equal true, false
  end

  test 'Anon user cannot update tab' do
    tab = tabs(:one)

    patch :update, id: tab.id, tab: { name: 'Some other name', description: 'Some desc',
                                      user_id: @user.id, splitters: []
                                    }

    tab_in_db = Tab.find_by_id(tab.id)
    assert_equal tab_in_db.name, tab.name
    assert_equal tab_in_db.description, tab.description
  end

  test 'Authed user can get edit for her own tab' do
    tab = tabs(:one)
    sign_in @user
    get :edit, id: tab
    assert_response :success
  end

  test 'Authed user cannot edit tab which is for another' do
    tab = tabs(:two)
    sign_in @user
    get :edit, id: tab
    assert_response :redirect
    assert_redirected_to({controller: :dashboard})
  end

  test 'Anon user cannot edit tab' do
    tab = tabs(:one)
    get :edit, id: tab
    assert_response :redirect
    assert_redirected_to({controller: :sessions, action: :login})
  end

  test 'Authed user can :destroy his tab' do
    sign_in @user

    tab = tabs(:one)
    assert_difference('Tab.count', -1) do
      delete :destroy, id: tab.id
    end
    assert_equal(Tab.where(id: tab).count, 0)
  end

  test 'Authed user cannot :destroy tab which belongs to other user' do
    sign_in @user

    tab = tabs(:two)
    assert_no_difference('Tab.count') do
      delete :destroy, id: tab.id
    end
    assert_equal(Tab.where(id: tab.id).count, 1)
  end

  test 'Anon user cannot :destroy tab' do
    tab = tabs(:one)
    assert_no_difference('Tab.count') do
      delete :destroy, id: tab.id
    end
  end

end
