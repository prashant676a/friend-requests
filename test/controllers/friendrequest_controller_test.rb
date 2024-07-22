require "test_helper"

class FriendrequestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friendrequest_index_url
    assert_response :success
  end
end
