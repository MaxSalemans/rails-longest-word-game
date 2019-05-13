require 'test_helper'

class NamesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get names_new_url
    assert_response :success
  end

  test "should get score" do
    get names_score_url
    assert_response :success
  end

end
