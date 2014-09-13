require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase
  include SessionsHelper, ExpensesHelper
  setup do
    @user = users(:one)
    @expense = expenses(:one)
  end

  test 'Authed user => :index redirects to DashboardController' do
    sign_in @user
    get :index
    assert_response :redirect
    assert_redirected_to({controller: :dashboard, action: :index})
  end
  
  test 'Anon user => :index redirects to LoginController' do
    get :index
    assert_response :redirect
    assert_redirected_to({controller: :sessions, action: :login})
  end

  test 'Authed user can get :new' do
    sign_in @user
    get :new
    assert_response :success
  end

  test 'Anon user cannot get :new' do
    get :new
    assert_response :redirect
    assert_redirected_to({controller: :sessions, action: :login})
  end

  test 'Authed user can create valid expense' do
    sign_in @user
    assert_difference('Expense.count') do
      post :create, expense: { C_NAME => 'aaa', C_AMOUNT => 123, C_DESCRIPTION => 'describe' }
    end
    # assert_redirected_to expenses_path(assigns(:expense))
  end

  test 'Anon user cannot create expense' do
    assert_no_difference('Expense.count') do
      post :create, expense: { C_NAME => 'aaa', C_AMOUNT => 123, C_DESCRIPTION => 'describe' }
    end
    assert_redirected_to({controller: :sessions, action: :login})
  end

  test 'Authed user can get :edit' do
    sign_in @user
    get :edit, id: @expense
    assert_response :success
  end

  test 'Anon user cannot get :edit' do
    get :edit, id: @expense
    assert_response :redirect
    assert_redirected_to({controller: :sessions, action: :login})
  end

  test 'Authed user can update existing expense' do
    sign_in @user
    new_name, new_amt, new_desc = 'blah_expense', 5432.1, 'described differently'
    patch :update, id: @expense.id, expense: { C_USER_ID => @user.id, C_NAME => new_name, 
                C_AMOUNT => new_amt, C_DESCRIPTION => new_desc }
    
    expense_in_db = Expense.find_by_id(@expense.id)
    assert_equal(expense_in_db.name, new_name)
    assert_equal(expense_in_db.amount, new_amt)
    assert_equal(expense_in_db.description, new_desc)
  end

  test 'Unauthed user cannot update existing expense' do
    new_name, new_amt, new_desc = 'blah_expense', 5432.1, 'described differently'
    patch :update, id: @expense.id, expense: { C_USER_ID => @user.id, C_NAME => new_name, 
                C_AMOUNT => new_amt, C_DESCRIPTION => new_desc }

    assert_response :redirect
    assert_redirected_to({controller: :sessions, action: :login})
    
    expense_in_db = Expense.find_by_id(@expense.id)
    assert_equal(expense_in_db.name, @expense.name)
    assert_equal(expense_in_db.amount, @expense.amount)
    assert_equal(expense_in_db.description, @expense.description)
  end

  test 'Authed user can get :show' do
    sign_in @user
    get :show, id: @expense
    assert_response :success
  end

  test 'Unauthed user cannot get :show' do
    get :show, id: @expense
    assert_response :redirect
    assert_redirected_to({controller: :sessions, action: :login})
  end

  test 'Authed user can delete his/her expense' do
    sign_in @user
    assert_difference('Expense.count', -1) do
      delete :destroy, id: @expense
    end
  end

  test 'Authed user cannot delete another user\'s expense' do
    sign_in @user
    expense2 = expenses(:two)
    assert_no_difference('Expense.count') do
      delete :destroy, id: expense2
    end
  end

end
