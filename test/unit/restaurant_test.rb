require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    restaurant = Restaurant.new
    assert restaurant.valid?, "unable to create restaunt"
  end
end
