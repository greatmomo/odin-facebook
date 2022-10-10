require "test_helper"

class FriendRequestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friend_request_index_url
    assert_response :success
  end
end
