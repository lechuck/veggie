require 'test_helper'

class PortionsControllerTest < ActionController::TestCase
  def setup
    activate_authlogic
    @restaurant = restaurants(:bamboo)
    @user = users(:mikko)
    @portion = portions(:currytofu)
    UserSession.create(@user)
  end

  test "user should get new" do
    get :new, :restaurant_id => @restaurant.to_param
    assert_response :success
    assert_not_nil assigns(:portion)
    assert_not_nil assigns(:restaurant)

  end

  test "should get edit" do
    get :edit, :restaurant_id => @restaurant.to_param, :id=>@portion.to_param
    assert_response :success
    assert_not_nil assigns(:portion)
    assert_not_nil assigns(:restaurant)
  end

  test "should create a new portion" do
    assert_difference('@restaurant.portions.count') do
      post :create, :restaurant_id => @restaurant.to_param, :portion => {:name => "Uusi annos"}
    end
    assert_redirected_to @restaurant
    assert_equal 'Portion was succesfully created', flash[:notice]
  end

  test "should render new if new portions validations fail" do
    name = "Kungpo Tofu12321312321432141"
    post :create, :restaurant_id => @restaurant.to_param, :portion => {:name => name}
    assert_no_difference('@restaurant.portions.count') do
      post :create, :restaurant_id => @restaurant.to_param, :portion => {:name => name}
    end
    assert_template 'new'
    assert_select '#error_explanation'
  end

  test "admin should be able to edit any a portion" do
    UserSession.create(users(:admin))
    new_veganmod = "Pyydä ilman osterikastiketta"
    put :update, :restaurant_id => @restaurant.to_param, :id => @portion.to_param,
      :portion => {:veganmod => new_veganmod}
    assert_redirected_to @restaurant
    assert (assigns(:portion).errors.empty?)
    assert_equal(new_veganmod, assigns(:portion).veganmod)
  end

  test "unsuccessful edit should render edit and show error" do
    UserSession.create(users(:admin))
    old_name = @portion.name
    put :update, :restaurant_id => @restaurant.to_param, :id => @portion.to_param,
      :portion => {:name => ''}
    assert_equal(old_name, @portion.name)
    assert_template 'edit'
  end

  test "should destroy comment is user is admin" do
    UserSession.create(users(:admin))
    delete :destroy, :restaurant_id => @restaurant.to_param, :id => @portion.to_param
    assert_redirected_to @restaurant
  end

  test "destroy should redirect somewhere (where?) if user is not admin" do
    delete :destroy, :restaurant_id => @restaurant.to_param, :id => @portion.to_param
    assert_response :redirect
  end

end
