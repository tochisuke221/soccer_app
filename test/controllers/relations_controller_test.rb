require 'test_helper'

class RelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get relations_create_url
    assert_response :success
  end

end
