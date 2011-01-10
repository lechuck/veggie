require 'test_helper'

class PortionTest < ActiveSupport::TestCase
  def setup
  @portion = portions(:currytofu)
  end
  test "cannot save a portion without a name" do
    @portion.name = nil
    assert !@portion.save
  end
end
