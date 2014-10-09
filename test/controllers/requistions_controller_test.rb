require 'test_helper'

class RequistionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
