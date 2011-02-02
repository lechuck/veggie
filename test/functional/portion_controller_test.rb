require 'test_helper'

class PortionControllerTest < ActionController::TestCase
  def setup
    @restaurant = restaurants(:bamboo)
    @user = users(:mikko)
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
  end

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
