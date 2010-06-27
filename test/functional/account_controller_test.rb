require 'test_helper'

class AccountControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get bids" do
    get :bids
    assert_response :success
  end

  test "should get history" do
    get :history
    assert_response :success
  end

end
