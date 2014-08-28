require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase
  injection_string = "'; Show tables;--"

  test 'Valid user is saved' do
    user = User.new({ fname: 'Aaa', lname: 'Bbb', email: 'a@b.c', password: 'test'})
    assert user.save
  end

  ## :fname tests
  test 'Invalid fname => fails to save' do
    user = User.new({ fname: 'abcdefg', lname: 'Bbb', email: 'a@b.c', password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { fname: ["is invalid"] } )
  end

  test 'SQL injection fname => fails to save' do
    user = User.new({ fname: injection_string, lname: 'Bbb', email: 'a@b.c', 
                      password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { fname: ["is invalid"] } )
  end

  test 'Blank fname => fails to save' do
    user = User.new({ fname: '', lname: 'Bbb', email: 'a@b.c', password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { fname: ["can't be blank", 'is invalid'] })
  end

  test 'Missing :fname => fails to save' do
    user = User.new({ lname: 'Bbb', email: 'a@b.c', password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { fname: ["can't be blank", "is invalid"] })
  end


  ## :lname tests
  test 'Invalid lname => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'abcdefg', email: 'a@b.c', password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { lname: ["is invalid"] })
  end

  test 'SQL injection lname => fails to save' do
    user = User.new({ fname: 'Abc', lname: injection_string, email: 'a@b.c', 
                      password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { lname: ["is invalid"] })
  end

  test 'Blank lname => fails to save' do
    user = User.new({ fname: 'Xyz', lname: '', email: 'a@b.c', password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { lname: ["can't be blank", 'is invalid'] })
  end

  test 'Missing :lname => fails to save' do
    user = User.new({ fname: 'Bbb', email: 'a@b.c', password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { lname: ["can't be blank", "is invalid"] })
  end

  ## :email tests
  test 'Invalid email => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', email: 'arthur#bibimbap.co.kr',
                      password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { email: ["is invalid"] })
  end

  test 'SQL injection email => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', 
                      email: injection_string, password: 'test'})
    assert_not user.save
    assert_equal(user.errors.messages, { email: ["is invalid"] })
  end

  ## :password tests
  test 'Short password => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', email: 'a@b.c', password: 'hi'})
    assert_not user.save
    assert_equal(user.errors.messages, { password: ['is too short (minimum is 3 characters)'] })
  end

  test 'Long password => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', email: 'a@b.c', 
                      password: 'bloodbloodbloodbloodbloodbloodbloodbloodbloodbloody'})
    assert_not user.save
    assert_equal(user.errors.messages, { password: ['is too long (maximum is 50 characters)'] })
  end
end
