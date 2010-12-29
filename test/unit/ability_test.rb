require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  def setup
    @user = Ability.new(users(:mikko))
    @user_id = users(:mikko).to_param
    @admin = Ability.new(users(:admin))
    @admin_id = users(:admin).to_param
    @guest = Ability.new(nil)
  end

  test "users can read all" do
    assert @user.can?(:read, :all)
  end

  test "user cannot create, update, or delete users" do
    assert @user.cannot?([:update, :destroy, :create], User)
  end

  test "user can only delete comments which she owns" do
    assert @user.can?(:delete, Comment.new(:user_id => @user_id))
    assert @user.cannot?(:delete, Comment.new)
  end

  test "user can only see her own email address" do
    assert @user.can?(:see_email, users(:mikko))
    assert @user.cannot?(:see_email, User.new)
  end

  test "user can edit only the portions she has created" do
    assert @user.can?(:update, Portion.new(:user_id => @user_id))
    assert @user.cannot?(:update, Portion.new)
  end

  test "guest can read Restaurants Comments and Reviews" do
    assert @guest.can?(:read, Restaurant)
    assert @guest.can?(:read, Comment)
    assert @guest.can?(:read, Review)
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
