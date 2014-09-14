require 'test_helper'

class ExpensesTest < ActiveSupport::TestCase
  include ExpensesHelper

  setup do
    @user = users(:one)
    ## TODO: Mock tabs
    @test_name, @test_amt, @test_desc, @test_tab_id = 'Expense1', 123.45, 
                              'Description1', 1
  end

  test 'Valid expense saves correctly' do
    expense = Expense.new({ C_USER_ID => @user.id, C_NAME => @test_name, 
                            C_AMOUNT => @test_amt, C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert expense.save
  end

  test 'nil user_id => fails to save' do
    expense = Expense.new({ C_USER_ID => nil, C_NAME => @test_name, 
                            C_AMOUNT => @test_amt, C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert_not expense.save
    assert_equal(expense.errors.messages, { C_USER_ID => 
                                  ["is not a number", "can't be blank"] })
  end

  test 'missing user_id => fails to save' do
    expense = Expense.new({ C_NAME => @test_name, 
                            C_AMOUNT => @test_amt, C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert_not expense.save
    assert_equal(expense.errors.messages, { C_USER_ID => 
                                  ["is not a number", "can't be blank"] })
  end

  test 'non-numeric user_id => fails to save' do
    expense = Expense.new({ C_USER_ID => '3a', C_NAME => @test_name, 
                            C_AMOUNT => @test_amt, C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert_not expense.save
    assert_equal(expense.errors.messages, { C_USER_ID => ['is not a number'] })
  end


  test 'Short name => fails to save' do
    expense = Expense.new({ C_USER_ID => @user.id, C_NAME => 'ab', 
                            C_AMOUNT => @test_amt, C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert_not expense.save
    assert_equal(expense.errors.messages, { C_NAME => 
                                  ['is too short (minimum is 3 characters)'] })
  end

  test 'Long name => fails to save' do
    expense = Expense.new({ C_USER_ID => @user.id, C_NAME => 'a' * 201, 
                            C_AMOUNT => @test_amt, C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert_not expense.save
    assert_equal(expense.errors.messages, { C_NAME => 
                                  ['is too long (maximum is 200 characters)'] })
  end

  test 'Missing name => fails to save' do
    expense = Expense.new({ C_USER_ID => @user.id, 
                            C_AMOUNT => @test_amt, C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert_not expense.save
    assert_equal(expense.errors.messages, { C_NAME => 
                    ['is too short (minimum is 3 characters)', "can't be blank"] })
  end

  test 'Missing amount => fails to save' do
    expense = Expense.new({ C_USER_ID => @user.id, C_NAME => @test_name, 
                            C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert_not expense.save
    assert_equal(expense.errors.messages, { C_AMOUNT => 
                            ['is not a number', "can't be blank"] })
  end

  test 'non-numeric amount => fails to save' do
    expense = Expense.new({ C_USER_ID => @user.id, C_NAME => @test_name, 
                            C_AMOUNT => '3b', C_DESCRIPTION => @test_desc,
                            C_TAB_ID => @test_tab_id
                          })
    assert_not expense.save
    assert_equal(expense.errors.messages, { C_AMOUNT => 
                            ['is not a number'] })
  end
end 
