require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  def setup
    @user = Ability.new(users(:mikko))
    @user_id = users(:mikko).to_param
    @admin = Ability.new(users(:admin))
    @admin_id = users(:admin).to_param
    @guest = Ability.new(nil)
  end

  test "everyone can read all" do
    assert @user.can?(:read, :all)
    assert @guest.can?(:read, :all)
    assert @admin.can?(:read, :all)
  end
  
  test "user can only delete comments which she owns" do
    assert @user.can?(:delete, Comment.new(:user_id => @user_id))
    assert @user.cannot?(:delete, Comment.new)
  end

  test "guest cannot delete, update or create anything" do
    assert @guest.cannot?(:delete, :all)
    assert @guest.cannot?(:create, :all)
    assert @guest.cannot?(:update, :all)
  end



  test "admins should be able to do anything" do
    assert @admin.can(:manage, :all)
  end

end
