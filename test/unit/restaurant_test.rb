require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase

  def setup
    @new_restaurant = Restaurant.new
    @restaurant = restaurants(:bamboo)
    @new_user = User.new
    @user = users(:admin)

  end

  test "cannot create a restaurant without a name" do
    @new_restaurant.info  = 'foo'
    assert !@new_restaurant.save, "Saved restaurant without a name"
  end

  test "cannot create a restaurant without info" do
    @new_restaurant.name = 'foo'
    assert !@new_restaurant.save, "Saved restaurant without info"
  end

  test "one user can like a restaurant once" do
    @restaurant.likes.destroy_all
    assert_difference('@restaurant.likes.count', 1, 'user couldn\'t like even once') do
      @restaurant.like(@user)
    end
    assert_no_difference('@restaurant.likes.count', "same user could add two likes") do
      @restaurant.like(@user)
    end
  end
end

