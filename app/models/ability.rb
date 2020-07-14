# Class Used for permissions on the website, and
# Easy to check using can can helper methods
# Note that one user can have multiple roles
class Ability
  include CanCan::Ability

  def initialize(user)
    if !user.blank?
      can :index, :home
      can :my_account_users, :user
      can :destroy, User, :user_id => user.id
    end
    user ||= User.new

    # Schedule:helper is used for which schedules they have access too

    # Everyone have access
    can :contact_email, :email
    can :contact_email2, :email
    can :read, Schedule

    user_roles = user.roles.pluck(:role_name)

    # Head Admin, can access everything
    if Db_queries.check_list_user_roles_smart(user_roles, ["Head Admin"])
      can :manage, :all
      # Don't have a child, so wouldn't make sense to show details of there child either
      cannot :my_children_details, Child
    end

    # Run Leader
    if Db_queries.check_list_user_roles_smart(user_roles, ["Run Leader"])
      can :my_account_coach, Coach
      can :read, Child
      can :read, Attendance
      can :create, Attendance
      can :update, Attendance
      coach_id = Coach.where(user_id: user.id).first.id
      can :helper, Schedule, Schedule.joins(session_helper: :schedule).where(session_helpers: {coach_id: coach_id})
      can :view_runleader, Schedule
      can :attendance, Child
      can [:read, :create], InjuryRecord
      can :mark_attendance, Child
      can :numbers_coaches, Coach
      can [:index, :display], Gallery
    end

    # Volunteer
    if Db_queries.check_list_user_roles_smart(user_roles, ["Volunteer"])
      can :my_account_coach, Coach
      can :read, Schedule
      can :attendance, Child
      can :numbers_coaches, Coach
      can :view_runleader, Schedule
      can [:index, :display], Gallery
    end

    # Parent
    if Db_queries.check_list_user_roles_smart(user_roles, ["Parent"])
      can :my_account_parent, Parent
      can :my_children, Child
      can :add_child, Child
      can :edit_children, Child
      can :create, Child
      can :childrens_group, Child
      can :my_children_details, Child
      can [:show, :index, :update, :destroy], Child, :parent_id => user.parent.id
      can [:read, :update, :destroy, :create], EmergencyContact, :child_id => user.parent.child.ids
      if !user.parent.child.pluck(:group_id).compact.blank?
        can [:index, :display], Gallery
      end
    end

    # Treasurer
    if Db_queries.check_list_user_roles_smart(user_roles, ["Treasurer"])
      can :read, Child
      can :attendance, Child
      can :numbers_coaches, Coach
      can :view_children_payments, Child
      can :view_runleader, Schedule
      can :mark_attendance, Child
      can [:read, :create], InjuryRecord
      can :helper, Schedule
      can [:index, :display], Gallery
    end

    # Welfare Officer
    if Db_queries.check_list_user_roles_smart(user_roles, ["Welfare Officer"])
      can :email_application_status, :email
      can :read, Coach
      can :create, Coach
      can :update, Coach
      can :email_coach, :email
      can :email_coach2, :email
      can :email_coach3, :email
      can :email_expiration, :email
      can :approve_children, Child
      can :email_application_status2, :email
    end

    # MS, CS, WO
    if Db_queries.check_list_user_roles_smart(user_roles, ["Member Secretary", "Coach Secretary", "Welfare Officer"])
      can [:read, :create], InjuryRecord
      can :numbers_coaches, Coach
      can :attendance, Child
      can :read, Child
      can :view_runleader, Schedule
      can :mark_attendance, Child
      can :helper, Schedule
      can :read, EmergencyContact
      can [:index, :display], Gallery
    end

    #Coach Secretary
    if Db_queries.check_list_user_roles_smart(user_roles, ["Coach Secretary"])
      can :read, Group
      can :update, Group
      can :create, Group
      can :move_members, Child
      can :read, Coach
      can :update, Coach
      can :email_coach, :email
      can :email_coach2, :email
      can :email_coach3, :email
      can [:read, :update, :create], Schedule
      can :assign_coaches, Coach
      can :email_expiration, :email
      can :email_expiration2, :email
    end

    # Member Secretary (MS)
    if Db_queries.check_list_user_roles_smart(user_roles, ["Member Secretary"])
      can :manage, UserRole
      can :email_application_status, :email
      can :approve_children, Child
      can [:read, :create, :update, :our_events], Event
      can [:read, :update], Group
      can :move_members, Child
      can :reset_payments, Child
      can :email_group, :email
      can :email_group2, :email
      can :email_group3, :email
      can :email_user, :email
      can :email_user2, :email
      can :email_user3, :email
      can :email_user4, :email
      can :my_account_users, :user
      can :add_users, User
      can :create, Parent
      can :read, Coach
      can [:index, :create, :destroy, :display], Gallery
    end
  end
end
