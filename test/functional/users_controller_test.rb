require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    activate_authlogic
    @user = users(:mikko)
  end

  test "should get index" do
    UserSession.create(@user)
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {:username => 'timmy', :password => 'timmy', :password_confirmation => 'timmy',
        :email => 'timmy@test.com'}
    end
    assert_redirected_to users_path
  end

  test "should show user" do
    UserSession.create(@user)
    get :show, :id => @user
    assert_response :success
  end

  test "should get edit" do
    UserSession.create(@user)
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    UserSession.create(@user)
    put :update, :id => @user.to_param, :user => @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    UserSession.create(users(:admin))
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to users_path
  end
end
