require 'test_helper'

class PracticesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get practices_new_url
    assert_response :success
  end
end
