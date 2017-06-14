class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    guest = User.new
    guest.role = Role.new
    guest.role.name = "Guest"
    user ||= guest # Guest user
    
    if user.admin?
      can :manage, :all
    elsif user.member?

        can :read, Adoption
        can :create, Adoption
        can :update, Adoption do |adoption|
            adoption.try(:user)==user
        end
        can :destroy, Adoption do |adoption|
            adoption.try(:user)==user
        end

        can :read, Animal
        can :create, Animal
        can :update, Animal do |animal|
            animal.try(:user)==user
        end
        can :destroy, Animal do |animal|
            animal.try(:user)==user
        end

        can :read, Comment
        can :create, Comment
        can :update, Comment do |comment|
            comment.try(:user)==user
        end
        can :destroy, Comment do |comment|
            comment.try(:user)==user
        end

        can :read, Image
        can :create, Image
        can :update, Image do |image|
            image.animal.try(:user)==user || image.pet.try(:user)==user ||
            image.information.try(:user)==user || image.try(:user)==user
        end
        can :destroy, Image do |image|
            image.animal.try(:user)==user || image.pet.try(:user)==user ||
            image.information.try(:user)==user || image.try(:user)==user                 
        end

        can :read, Event
        can :read, Information

        can :read, Notification do |notification|
            notification.try(:user)==user
        end
        can :destroy, Notification do |notification|
            notification.try(:user)==user
        end

        can :read, Pet
        can :create, Pet
        can :update, Pet do |pet|
            pet.try(:user)==user
        end
        can :destroy, Pet do |pet|
            pet.try(:user)==user
        end

        can :read, Risk
        can :create, Risk
        can :update, Risk do |risk|
            risk.try(:user)==user
        end
        can :destroy, Risk do |risk|
            risk.try(:user)==user
        end


    else
      can :read, :all
    end
  end
end
