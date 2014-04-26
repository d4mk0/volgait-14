class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all                   # allow everyone to read everything
    if user
      if user.admin? 
        can :manage, :all
        can :access, :rails_admin       # only allow admin users to access Rails Admin
        can :dashboard                  # allow access to dashboard
      elsif user.editor? 
        can :manage, [Question, Answer]
        can :access, :rails_admin       # only allow admin users to access Rails Admin
        can :dashboard                  # allow access to dashboard
      else
        can :manage, [Question, Answer] do |o|
          o.user == user
        end
      end
    end
      
  end
end
