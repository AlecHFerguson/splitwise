require_relative '../test_helper'

class UserMethodsTest < ActiveSupport::TestCase
  setup do
    @valid_user = User.new({ fname: 'Aaa', lname: 'Bbb', email: 'a@b.c', password: 'test'})
    @valid_user.save
  end
  test 'Matching password => returns the user' do
    user = User.find_by(email: @valid_user.email)
    assert_equal user.authenticate(@valid_user.password), @user
  end

  test 'Mismatched password => return false' do
    user = User.find_by(email: @valid_user.email)
    assert_equal(user.authenticate('blahblahblah'), false)
  end
end