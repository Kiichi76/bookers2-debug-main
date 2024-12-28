require "test_helper"

class FavaritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favarites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favarites_destroy_url
    assert_response :success
  end
end
