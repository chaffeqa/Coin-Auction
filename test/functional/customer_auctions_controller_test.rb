require 'test_helper'

class CustomerAuctionsControllerTest < ActionController::TestCase
  test "should get categories" do
    get :categories
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

end
