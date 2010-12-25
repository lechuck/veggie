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
        # signed in users can read everything, create stuff and delete their own comments
      else
        can :read, :all
        can :create, [Restaurant, Comment, Portion, Review]
        can [:like, :add_tags], Restaurant
        can :delete, Comment, :user_id => user.id
      end

      # guests can only read stuff
    else
      can :read, :all
    end
  end
end
