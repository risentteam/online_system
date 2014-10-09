require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get ajaxPages" do
    get :ajaxPages
    assert_response :success
  end

end
