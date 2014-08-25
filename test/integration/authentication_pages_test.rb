require_relative '../test_helper'
class AuthenticationPagesTest < ActionDispatch::IntegrationTest
  test 'get login page' do
    get '/login'
    assert_response :success
  end
end

# describe 'Authentication' do 
#   describe 'signin_page' do
#     before { visit login_path }

#     it { should have_content('Sign in') }
#     it { should have_title('Sign in') }

#   end
# end
