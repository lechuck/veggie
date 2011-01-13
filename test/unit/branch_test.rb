require 'test_helper'

class BranchTest < ActiveSupport::TestCase

  def setup
    @branch = branches(:bamboo)
  end

  test "branch must belong to a restaurant" do
    @branch.restaurant = nil
    assert !@branch.save
  end

  test "branch must have a street address" do
    @branch.street = nil
    assert !@branch.save
  end

  test "branch must be in some city" do
    @branch.city = nil
    assert !@branch.save
  end

end
