require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:one)
    @restaurant = restaurants(:bamboo)
  end

  test "should get new" do
    get :new, :restaurant_id => @restaurant
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post :create, :review => @review.attributes, :restaurant_id => @restaurant
    end

    assert_redirected_to @restaurant
  end

=begin
  test "should get edit" do
    get :edit, :id => @review.to_param
    assert_response :success
  end
=end

  test "should update review" do
    put :update, :id => @review.to_param, :review => @review.attributes
    assert_redirected_to review_path(assigns(:review))
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete :destroy, :id => @review.to_param
    end

    assert_redirected_to reviews_path
  end
end
