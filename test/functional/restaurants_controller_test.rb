require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  setup do
    activate_authlogic
    @restaurant = restaurants(:bamboo)
    @user = users(:mikko)
  end

  test "should add like to restaurant if no previous like and has ability" do
    UserSession.create(@user)
    restaurant = restaurants(:maoz)
    assert_difference('restaurant.likes.count', 1) do
      post :like, :id => restaurants(:maoz)
    end
    assert_redirected_to restaurant

    # user cannot like a restaurant two times
    assert_no_difference('restaurant.likes.count') do
      post :like, :id => restaurants(:maoz)
    end
    assert_redirected_to restaurant
    assert_not_nil flash[:alert]
  end

  test "should add tags to restaurant if they don't exist already" do
    UserSession.create(@user)
    tags = "uusi tagi, toinen uusi tagi"
    assert_difference('@restaurant.tags.count', 2) do
      post :add_tags, :id => @restaurant, :taglist => tags
    end
    assert_redirected_to @restaurant
    assert_no_difference('@restaurant.tags.count') do
      post :add_tags, :id => @restaurant, :taglist => tags
    end
    assert_redirected_to @restaurant
  end

  test "should give an error message if adding empty tags" do
    UserSession.create(@user)
    tags = ", ,"
    assert_no_difference('@restaurant.tags.count') do
      post :add_tags, :id => @restaurant, :taglist => tags
    end
    assert_redirected_to @restaurant
    assert_not_nil flash[:alert]
  end

  test "should render tag-page that displays found restaurants" do
    get :tag, :id => "a tag"
    assert_template 'tag'
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurants)
    toplists = %w'top_food top_service top_environment last_added best_rated most_rated'
    sum = 0
    toplists.each do |toplist|
      assert_not_nil assigns(toplist)
      sum = sum + assigns(toplist).count
    end
    assert_template :partial => '_toplist', :count => sum
  end

  test "should get show" do
    get :show, :id =>@restaurant
    assert_response :success
    assert_template :partial => 'shared/_like', :count => 1
    assert_template :partial => '_average_rating', :count => 1
    assert_template :partial => 'ratings/_form', :count => 1
    assert_template :partial => 'comments/_comment', :count => @restaurant.comments.count
  end
  
  test "should get new if user logged in" do
    UserSession.create(@user)
    get :new
    assert_response :success
  end

  test "should get edit if user is admin" do
    UserSession.create(users(:admin))
    get :edit, :id => @restaurant
    assert_response :success
    assert_not_nil assigns(:restaurant)
  end

  test "should create restaurant if has the ability" do
    UserSession.create(@user)
    name = "New Restaurant"
    info = "New Restaurant info"
    assert_difference('Restaurant.count') do
      post :create, :restaurant => {:name => name, :info => info, :user => @user}
    end
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should not create two restaurants with the same name" do
    UserSession.create(@user)
    assert_no_difference('Restaurant.count') do
      post :create, @restaurant.attributes
    end
    assert_template 'new'
    assert_not_nil assigns(:restaurant).errors
  end

  test "should update restaurant if has ability" do
    UserSession.create(users(:admin))
    put :update, :id => @restaurant.to_param, :restaurant => @restaurant.attributes
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should render edit if update fails due to validations"do
    UserSession.create(users(:admin))
    old_name = @restaurant.name
    name = ""
    info = @restaurant.info
    user = @restaurant.user
    put :update, :id => @restaurant, :restaurant => {:name => name, :info => info, :user => user}
    assert_template 'edit'
    assert_equal old_name, @restaurant.name
  end

  test "should destroy restaurant if has the ability" do
    UserSession.create(users(:admin))
    assert_difference('Restaurant.count', -1) do
      delete :destroy, :id => @restaurant
    end
    assert_redirected_to restaurants_path
  end

end
