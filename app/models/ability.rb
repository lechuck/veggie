class Ability
  include CanCan::Ability

  # non-rest actions:
  # => like, add_tags,  in restaurants_controller
  # => delete in comments_controller

  def initialize(user)
    if user
      # admins can do anything!
      if user.admin?
        can :manage, :all
        # signed in users can read everything and create stuff and delete their own comments
      else
        can :read, :all
        can :see_email, User, :id => user.id # user can only see her own email address
        can :create, [Restaurant, Comment, Portion, Rating]
        can :update, Rating
        can [:like, :add_tags], Restaurant
        can :delete, Comment, :user_id => user.id, :deleted => false
        can :update, User, :id => user.id
        can :update, Portion, :user_id => user.id
      end

      # guests can read stuff but not user details
    else
      can :read, [Restaurant, Comment, Portion, Rating]
      can :create, [User]
    end
  end
end
