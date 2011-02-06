require 'test_helper'

class PortionTest < ActiveSupport::TestCase
  def setup
  @portion = portions(:currytofu)
  @user = users(:tony)
  end
  test "cannot save a portion without a name" do
    @portion.name = nil
    assert !@portion.save
  end

  test "cannot save a portion that doesn't belong to any restaurant" do
    @portion.restaurant = nil
    assert !@portion.save
  end

  test "cannot save a portion that doesn't belong to any user" do
    @portion.user = nil
    assert !@portion.save
  end

  test "cannot create two portions with same name" do
    restaurant = @portion.restaurant
    new_portion = Portion.new(:name => @portion.name, :user => @user, :restaurant => @portion.restaurant)
    assert !new_portion.save
    assert_not_nil(new_portion.errors)
  end

  test "portion can be updated" do
    @portion.veganmod = "Pyydä ilman juustooo"
    assert @portion.save

  end
end
