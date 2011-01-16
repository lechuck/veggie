require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  setup do
    @rating = ratings(:one)
    @restaurant = restaurants(:bamboo)
  end

  test "should get new" do
    get :new, :restaurant_id => @restaurant
    assert_response :success
  end

  test "should create rating" do
    assert_difference('Rating.count') do
      post :create, :rating => @rating.attributes, :restaurant_id => @restaurant
    end

    assert_redirected_to @restaurant
  end

=begin
  test "should get edit" do
    get :edit, :id => @rating.to_param
    assert_response :success
  end
=end

  test "should update rating" do
    put :update, :id => @rating.to_param, :rating => @rating.attributes
    assert_redirected_to rating_path(assigns(:rating))
  end

  test "should destroy rating" do
    assert_difference('rating.count', -1) do
      delete :destroy, :id => @rating.to_param
    end

    assert_redirected_to ratings_path
  end
end
