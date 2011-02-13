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

  test "a restaurant can be created" do
    new_restaurant = Restaurant.new
    new_restaurant.user = @user
    new_restaurant.info = "This is a new restaurant"
    new_restaurant.name = @restaurant.name.reverse
    assert new_restaurant.save

  end
  test "cannot create two restaurants with the same name" do
    new_restaurant = Restaurant.new
    new_restaurant.user = @user
    new_restaurant.info = "This is a new restaurant"
    new_restaurant.name = @restaurant.name
    assert !new_restaurant.save
  end

  test "cannot create a restaurant without info" do
    @restaurant.info  =  nil
    assert !@restaurant.save
  end

  test "restaurant must belong to a user" do
    @restaurant.user = nil
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

  test "top_by_attribute is ordered by rating" do
    attribute = 'food'
    # restaurants is an ordered hash
    restaurants = Restaurant.top_by_attribute(attribute, Restaurant.count)
    # check that the first restaurant has greatest average and last the smallest
    average_ratings = Rating.group(:restaurant).average(attribute)
    assert_equal average_ratings.values.max, restaurants.first.rating
    assert_equal average_ratings.values.min, restaurants.last.rating
    # TODO: how to compare floating point numbers correct?
    # and that all the values in between are ordered correctly
    previous_rating = nil
    restaurants.each do |restaurant|
      unless previous_rating.nil?
        assert (restaurant.rating <= previous_rating)
      end
      previous_rating = restaurant.rating
    end  
  end

  test "top_by_average_rating returns restaurants ordered by average rating" do
    # note that if restaurant doesn't have any ratings it isn't included in this array:
    actuals = Restaurant.top_by_average_rating(Restaurant.count)
    # create a array of [restaurant, average_rating] pairs sorted by average rating:
    expecteds = Restaurant.all
    expecteds.map! { |restaurant| [restaurant, restaurant.average_rating]  }
    expecteds.sort! {|a,b| -1*(a[1] <=> b[1])}

    #compare the average-ratings between expected and actual
    expecteds.each_with_index do |value, index|
      break if (value[1] == 0) # in case there were restaurants with no ratingsn
      assert_equal(value[1], actuals[index].average_rating)
    end
  end

  test "most_rated_in_n_days returns restaurants ordered ratings count in given time period" do
    n = 7
    actuals = Restaurant.most_rated_in_n_days(n, Restaurant.count)
    expecteds = Rating.where(["created_at > ?", n.days.ago]).group(:restaurant).count(:all)
    expecteds = expecteds.sort {|a,b| -1*(a[1] <=> b[1])}

    #compare the average-ratings between expected and actual
    expecteds.each_with_index do |value, index|
      assert_equal(value[0].ratings.size, actuals[index].ratings.size)
    end
  end

end

    



