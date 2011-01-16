require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  def setup
    @rating = ratings(:bamboo1)
    @user = users(:mikko)
    @restaurant = restaurants(:bamboo)
  end

  test "rating must include all the dimensions" do
    @rating.food = nil
    assert !@rating.save
    @rating.food = 5

    @rating.service = nil
    assert !@rating.save
    @rating.food = 5

    @rating.environment = nil
    assert !@rating.save
    @rating.environment = 5
  end

  test "rating must belong to a user" do
    @rating.user = nil
    assert !@rating.save
  end

  test "rating must belong to a restaurant" do
    @rating.restaurant = nil
    assert !@rating.save
  end

  test "a user can only rate a restaurant once" do
    @restaurant.ratings.destroy_all
    assert Rating.create(:restaurant => @restaurant, :user => @user, :food => 5, :service => 5, :environment => 5)
    second_rating = Rating.create(:restaurant => @restaurant, :user => @user, :food => 5, :service => 5, :environment => 5)
    assert !second_rating.save
    assert !second_rating.errors.empty?
  end

  test "sum_value returns the sum of rating's dimensions" do
    actual_sum = @rating.sum_value
    expected_sum = @rating.environment + @rating.service + @rating.food
    assert_equal(expected_sum, actual_sum)
  end
  
end
