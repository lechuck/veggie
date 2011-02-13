require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  setup do
    activate_authlogic
    @user = users(:mikko)
    UserSession.create(@user)
    @rating = ratings(:bamboo1)
    @restaurant_with_rating = restaurants(:bamboo)
    @restaurant_without_rating = restaurants(:happy_garden)
  end

  test "should get new" do
    get :new, :restaurant_id => @restaurant_with_rating
    assert_response :success
  end

  test "should get edit" do
    UserSession.create(@rating.user)
    get :edit, :restaurant_id => @rating.restaurant, :id => @rating
    assert_response :success
  end

  test "should create rating" do
    assert_difference('@restaurant_without_rating.ratings.count') do
      post :create, :restaurant_id => @restaurant_without_rating,
        :rating => {:food => 5, :environment => 5, :service => 5}
    end
    assert_redirected_to @restaurant_without_rating
  end

  test "should render new-view and display error messages if create validations fail" do
    UserSession.create(@rating.user)
    assert_no_difference('@rating.restaurant.ratings.count') do
      post :create, :restaurant_id => @rating.restaurant,
        :rating => {:food => 1, :environment => 2, :service => 3}
    end
    assert_template 'new'
    assert_select '#error_explanation'
    assert_not_nil(assigns(:rating).errors)
  end

  test "should create a rating via ajax" do
    assert_difference('@restaurant_without_rating.ratings.count') do
      xhr :post, :create, :restaurant_id => @restaurant_without_rating,
        :rating => {:food => 5, :environment => 5, :service => 5}
    end
    assert_response :success
    assert_template 'update'
  end

  test "should display an error message if create validations fail via ajax" do
    UserSession.create(@rating.user)
    assert_no_difference('@rating.restaurant.ratings.count') do
      xhr :post, :create, :restaurant_id => @rating.restaurant,
        :rating => {:food => 5, :environment => 5, :service => 5}
    end
    assert_template 'error'
    assert_not_nil(assigns(:rating).errors)
    # TODO: how to check that error message id displayed?
  end

  test "should update rating" do
    UserSession.create(@rating.user)
    put :update, :restaurant_id => @rating.restaurant, :id => @rating, :rating => @rating.attributes
    assert_redirected_to assigns(:restaurant)
  end

  # TODO: how does assert_select_jquery work?
  test "should update rating via ajax" do
    UserSession.create(@rating.user)
    xhr :put, :update, :restaurant_id => @rating.restaurant, :id => @rating, :rating => @rating.attributes
    assert_template 'update'
  end

  test "user cannot update other user's rating" do
    UserSession.create(users(:tony))
    put :update, :restaurant_id => @rating.restaurant, :id => @rating, :rating => @rating.attributes
    assert_redirected_to :login
  end

  test "user cannot update other user's rating via ajax" do
    UserSession.create(users(:tony))
    xhr :put, :update, :restaurant_id => @rating.restaurant, :id => @rating, :rating => @rating.attributes
    assert_redirected_to :login
  end

  test "should destroy rating if user is admin" do
    UserSession.create(users(:admin))
    assert_difference('Rating.count', -1) do
      delete :destroy, :restaurant_id => @restaurant_with_rating, :id => @rating
    end
    assert_redirected_to assigns(:restaurant)
  end

end
