require 'test_helper'

class LikeTest < ActiveSupport::TestCase
 
  def setup
    @like = likes(:mikkolikesbamboo)
    @user = users(:mikko)
    @restaurant = restaurants(:bamboo)
  end

  test "like must have a user"do
    @like.user = nil
    assert !@like.save
  end

  test "like must have a restaurant"do
    @like.restaurant = nil
    assert !@like.save
  end

  test "one user cannot like the same restaurant more than once" do
    new_like = Like.new(:user =>  @user, :restaurant => @restaurant)
    assert !new_like.save
    assert !new_like.errors.empty?

  end
end
