require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def  setup
    @bamboo = restaurants(:bamboo)
    @comment = comments(:bamboo_comment)
  end

  test "should get create" do
    get :create, :restaurant_id => @bamboo.to_param
    assert_response :success
  end

  test "should get update" do
    get :update, :restaurant_id => @bamboo.to_param, :id => @comment.to_param
    assert_response :success
  end

  test "should get delete" do
    get :delete, :restaurant_id => @bamboo.to_param, :id => @comment.to_param
    assert_response :success
  end

end
