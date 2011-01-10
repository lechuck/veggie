require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase

  def setup
    @new_restaurant = Restaurant.new
    @restaurant = restaurants(:bamboo)
    @new_user = User.new
    @user = users(:admin)
  end

  test "cannot create a restaurant without a name" do
    @restaurant.name  =  nil
    assert !@restaurant.save
  end

  test "cannot create a restaurant without info" do
    @restaurant.info  =  nil
    assert !@restaurant.save
  end

  test "one user can like a restaurant once" do
    @restaurant.likes.destroy_all
    assert_difference('@restaurant.likes.count', 1) do
      @restaurant.like(@user)
    end
    assert_no_difference('@restaurant.likes.count') do
      @restaurant.like(@user)
    end
  end

  test "top is ordered by rating" do
    attribute = 'food'
    # restaurants is an ordered hash
    restaurants = Restaurant.top(attribute, Restaurant.count)
    # check that the first restaurant has greatest average and last the smallest
    average_ratings = Review.group(:restaurant).average(attribute)
    assert_equal average_ratings.values.max, restaurants.first[1]
    assert_equal average_ratings.values.min, restaurants.last[1]
    # TODO: how to compare floating point numbers correct?
    # and that all the values in between are ordered correctly
    previous_rating = nil
    restaurants.each do |restaurant, rating|
      unless previous_rating.nil?
        assert (rating <= previous_rating)
      end
      previous_rating = rating
    end  
  end

end
    



