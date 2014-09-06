require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @test_fname = 'Abcdefg'
    @test_lname = 'Hijklmnop'
    @test_email = 'aaa@bbb.cc'
    @test_password = 'testing1'
    @injection_string = "'; Show tables;--"
  end

  test 'Valid user is saved' do
    user = User.new({ fname: @test_fname, lname: @test_lname, email: @test_email, 
                      password: @test_password, password_confirmation: @test_password })
    assert user.save
  end

  ## :fname tests
  test 'Invalid fname => fails to save' do
    user = User.new({ fname: 'abcdefg', lname: @test_lname, email: @test_email, 
                      password: @test_password, password_confirmation: @test_password })
    assert_not user.save
    assert_equal(user.errors.messages, { fname: ["is invalid"] } )
  end

  test 'SQL injection fname => fails to save' do
    user = User.new({ fname: @injection_string, lname: @test_lname, email: @test_email, 
                      password: @test_password, password_confirmation: @test_password })
    assert_not user.save
    assert_equal(user.errors.messages, { fname: ["is invalid"] } )
  end

  test 'Blank fname => fails to save' do
    user = User.new({ fname: '', lname: @test_lname, email: @test_email, password: @test_password,
                      password_confirmation: @test_password })
    assert_not user.save
    assert_equal(user.errors.messages, { fname: ["can't be blank", 'is invalid'] })
  end

  test 'Missing :fname => fails to save' do
    user = User.new({ lname: @test_lname, email: @test_email, password: @test_password, 
                      password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { fname: ["can't be blank", "is invalid"] })
  end


  ## :lname tests
  test 'Invalid lname => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'abcdefg', email: @test_email, 
                      password: @test_password, password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { lname: ["is invalid"] })
  end

  test 'SQL injection lname => fails to save' do
    user = User.new({ fname: 'Abc', lname: @injection_string, email: @test_email, 
                      password: @test_password, password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { lname: ["is invalid"] })
  end

  test 'Blank lname => fails to save' do
    user = User.new({ fname: 'Xyz', lname: '', email: @test_email, password: @test_password,
                      password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { lname: ["can't be blank", 'is invalid'] })
  end

  test 'Missing :lname => fails to save' do
    user = User.new({ fname: @test_lname, email: @test_email, password: @test_password,
                      password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { lname: ["can't be blank", "is invalid"] })
  end

  ## :email tests
  test 'Invalid email => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', email: 'arthur#bibimbap.co.kr',
                      password: @test_password, password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { email: ["is invalid"] })
  end

  test 'SQL injection email => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', email: @injection_string, 
                      password: @test_password, password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { email: ["is invalid"] })
  end

  test 'Blank email => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', email: '',
                      password: @test_password, password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { email: ["can't be blank", "is invalid"] })
  end

  test 'Missing email => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', password: @test_password,
                      password_confirmation: @test_password})
    assert_not user.save
    assert_equal(user.errors.messages, { email: ["can't be blank", "is invalid"] })
  end

  ## :password tests
  test 'Short password => fails to save' do
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', email: @test_email, password: 'hi',
                      password_confirmation: 'hi'})
    assert_not user.save
    assert_equal(user.errors.messages, { password: ['is too short (minimum is 3 characters)'] })
  end

  test 'Long password => fails to save' do
    long_pw = 'LesTroisTetonsLesTroisTetonsLesTroisTetonsLesTroisTetonsLesTroisTetons999abcd'
    user = User.new({ fname: 'Abcdefg', lname: 'Abcdefg', email: @test_email, 
                      password: long_pw, password_confirmation: long_pw })
    assert_not user.save
    assert_equal(user.errors.messages, { password: ['is too long (maximum is 50 characters)'] })
  end

  ## :password_confirmation tests
  test 'Non-matching password_confirmation => fails to save' do
    user = User.new({ fname: @test_fname, lname: @test_lname, email: @test_email, 
                      password: @test_password, password_confirmation: @test_password + 'a' })
    assert_not user.save
    assert_equal(user.errors.messages, 
                { password_confirmation: ["doesn't match Password"] } )
  end

  test 'Missing password_confirmation => fails to save' do
    user = User.new({ fname: @test_fname, lname: @test_lname, email: @test_email, 
                      password: @test_password })
    assert_not user.save
    assert_equal(user.errors.messages,
                { password_confirmation: ["can't be blank"] } )
  end

  test 'Blank password_confirmation => fails to save' do
    user = User.new({ fname: @test_fname, lname: @test_lname, email: @test_email, 
                      password: @test_password, password_confirmation: '' })
    assert_not user.save
    assert_equal(user.errors.messages, 
                { password_confirmation: ["doesn't match Password", "can't be blank"] } )
  end
end
