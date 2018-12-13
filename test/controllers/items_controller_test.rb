require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get items_home_url
    assert_response :success
  end

end
