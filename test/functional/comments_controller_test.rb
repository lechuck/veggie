require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def  setup
    activate_authlogic
    @restaurant = restaurants(:bamboo)
    @comment = comments(:bamboo_comment)
    @user = users(:mikko)
    UserSession.create(@user)
  end

  test "should get new" do
    get :new, :restaurant_id => @restaurant
    assert_response :success
    assert_equal(@restaurant, assigns(:restaurant))
    assert_not_nil assigns(:comment)
  end

  test "should create a comment and redirect to restaurant " do
    assert_difference('@restaurant.comments.count') do
      post :create, :restaurant_id => @restaurant, :comment =>{:comment => "asdafdaf"}
    end
    assert_redirected_to @restaurant
    assert_equal "Kommenttisi lisättiin", flash[:notice]
  end

  test "should mark comment as deleted" do
    put :delete, :restaurant_id => @comment.restaurant.to_param, :id => @comment.to_param
    assert_equal 'Kommentti on poistettu.', flash[:notice]
    assert_redirected_to @restaurant
    # why this doesn't work
    assert @comment.deleted?

  end

  test "should destroy a comment" do
    UserSession.create(users(:admin))
    assert_difference('@restaurant.comments.count', -1) do
      delete :destroy, :restaurant_id => @comment.restaurant, :id => @comment
    end
    assert_redirected_to @restaurant
  end

  test "should create a comment via ajax" do
    comment_body = 'Pretty pretty pretty pretty good!'
    assert_difference('@restaurant.comments.count') do
      xhr :post, :create, :restaurant_id => @restaurant, :comment =>{:comment => comment_body}
    end
    assert_match(comment_body ,@response.body)
  end

  test "should mark a comment deleted via ajax" do
    xhr :put, :delete, :restaurant_id => @restaurant, :id => @comment
    # why this doesn't work?
    assert @comment.deleted?

  end

end
