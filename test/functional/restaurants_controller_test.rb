require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post :create, :restaurant => @restaurant.attributes
    end

    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should show restaurant" do
    get :show, :id => @restaurant.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @restaurant.to_param
    assert_response :success
  end

  test "should update restaurant" do
    put :update, :id => @restaurant.to_param, :restaurant => @restaurant.attributes
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should destroy restaurant" do
    assert_difference('Restaurant.count', -1) do
      delete :destroy, :id => @restaurant.to_param
    end

    assert_redirected_to restaurants_path
  end
end
