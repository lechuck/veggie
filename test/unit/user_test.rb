require 'test_helper'

class UserTest < ActiveSupport::TestCase
  #fixtures :users

  # Introduce the set ups
  setup :setup_users
  
  def setup_users
    @timmy = User.new(:username => 'timmy', :password => 'timmy', :password_confirmation => 'timmy',
                :email => 'timmy@test.com')    
  end

  test "that the user has a valid name" do
    assert @timmy.valid?
  end
end
