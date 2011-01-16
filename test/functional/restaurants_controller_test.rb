require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  setup do
    @restaurant = restaurants(:bamboo)
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @ability.can :read, :all
    @controller.stubs(:current_ability).returns(@ability)
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

  test "should create restaurant if has the ability" do
    @ability.can :create, Restaurant
    assert_difference('Restaurant.count') do
      post :create, :restaurant => @restaurant.attributes
    end

    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should show restaurant" do
    get :show, :id => @restaurant.to_param
    assert_response :success
  end

  test "should get edit if has the ability to do so" do
    @ability.can :update, Restaurant
    get :edit, :id => @restaurant.to_param
    assert_response :success
  end

  test "should update restaurant if has ability" do
    @ability.can :update, Restaurant
    put :update, :id => @restaurant.to_param, :restaurant => @restaurant.attributes
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should destroy restaurant if has the ability" do
    @ability.can :destroy, Restaurant
    assert_difference('Restaurant.count', -1) do
      delete :destroy, :id => @restaurant.to_param
    end

    assert_redirected_to restaurants_path
  end
end
