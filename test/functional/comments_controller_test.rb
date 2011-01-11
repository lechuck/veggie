require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def  setup
    @restaurant = restaurants(:bamboo)
    @comment = comments(:bamboo_comment)
    @user = users(:mikko)
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
  end

  test "create redirects to restaurant if have create ability for comments " do
    @ability.can :create, Comment
    @ability.can :read, :all
    post :create, :restaurant_id => @restaurant.to_param, :comment => "asdafdaf", :user_id => @user.to_param
    assert_redirected_to @restaurant
    assert_equal "Kommenttisi lisättiin", flash[:notice]
  end

  test "should get update" do
    get :update, :restaurant_id => @restaurant.to_param, :id => @comment.to_param
    assert_response :success
  end

  test "should get delete" do
    put :delete, :restaurant_id => @restaurant.to_param, :id => @comment.to_param
    assert_response :success
  end

  def login(user)
    session[:user_id] = user.id
  end
end
