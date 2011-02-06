require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def  setup
    activate_authlogic
    @restaurant = restaurants(:bamboo)
    @comment = comments(:bamboo_comment)
    @user = users(:mikko)
    UserSession.create(@user)

  end

  test "create redirects to restaurant if have create ability for comments " do
    assert_difference('@restaurant.comments.count') do
      post :create, :restaurant_id => @restaurant, :comment =>{:comment => "asdafdaf"}
    end
    assert_redirected_to @restaurant
    assert_equal "Kommenttisi lisättiin", flash[:notice]
  end

  test "should mark comment as deleted" do
    put :delete, :restaurant_id => @restaurant.to_param, :id => @comment.to_param
    assert_equal 'Kommentti on poistettu.', flash[:notice]
    assert_redirected_to @restaurant
  end

end
