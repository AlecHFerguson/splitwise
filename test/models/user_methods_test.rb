require_relative '../test_helper'

class UserMethodsTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end
  test 'Matching password => returns the user' do
    user = User.find_by(email: @user.email)
    assert_equal(user.authenticate('testing1'), @user)
  end

  test 'Mismatched password => return false' do
    user = User.find_by(email: @user.email)
    assert_not(user.authenticate('blahblahblah'))
  end
end