require 'test_helper'

class Addresses﻿ControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get addresses﻿_create_url
    assert_response :success
  end

  test "should get destroy" do
    get addresses﻿_destroy_url
    assert_response :success
  end

end
