require '/home/alec/RailsProjects/splitwise/test/test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test 'Email and password are correct => session created' do

  end

  test 'Unknown email => redirected to /login' do
    
  end

  test 'Invalid password => redirected to /login' do
    
  end
end
