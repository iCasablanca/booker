require 'test_helper'

class HoursControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
