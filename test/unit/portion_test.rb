require 'test_helper'

class PortionTest < ActiveSupport::TestCase
  def setup
  @portion = portions(:currytofu)
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
end
