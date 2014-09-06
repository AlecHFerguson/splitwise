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

class RememberTokenTest < ActiveSupport::TestCase
  setup do
    @user_in_db = users(:one)
    @user = User.new({fname: 'Humble', lname: 'Test', email: 'humble@test.com',
                      password: 'testing1', password_confirmation: 'testing1'})
    @user.save
  end

  test 'Remember token is not blank' do
    assert_not_nil @user.remember_token
    assert_not_equal(@user.remember_token, '')
  end
end