require 'test_helper'

class GreedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get greeds_index_url
    assert_response :success
  end

end
