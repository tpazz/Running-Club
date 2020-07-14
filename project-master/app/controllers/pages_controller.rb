class PagesController < ApplicationController

  # Home
  def home

  end

  def new_admin
    authorize! :create, User
    @user = User.new
    @user.roles << @user.roles.new
  end

  def new_admin_post
    authorize! :create, User
    @user = User.new(admin_signup)

    # If user tried changing the input using inspect element
    if ["Parent", "Volunteer", "Run Leader"].include? @user.roles.pluck(:role_name).first
      redirect_to "/"
    end

    if @user.save
      redirect_to "/"
    else
      render 'pages/new_admin'
    end
  end

  # Page where all the phone numbers of coaches are displayed
  def numbers_coaches
    authorize! :numbers_coaches, Coach
  end

  # Page for adding a child
  def add_child
    authorize! :add_child, Child
  end

  # My account page for the type of user Parent
  def my_account_parent
    authorize! :my_account_parent, Parent
  end

  # My account page for the type of user Coach
  def my_account_coach
    authorize! :my_account_coach, Coach
  end

  # My account page for other types of users orther than Parent and Coach
  def my_account_users
    authorize! :my_account_users, :user
  end

  # Page for resetting all the payment information of members
  def reset_payments
    authorize! :reset_payments, Child
  end

  # Sign Up form
  def signup

  end

  # Sign In form
  def signin

  end

  # Home page after the user is Logged In
  def post_signin
    authorize! :index, :home
  end

  # Schedule page
  def schedule

  end

  # Gallery page
  def gallery

  end

  # Contact page
  def contact

  end

  # My children page for a Parent
  def my_children
    authorize! :my_children, Child
  end

  # Page for updating the payment status
  def payment_done
    authorize! :reset_payments, Child
    Db_queries.set_children_all_unpaid()
  end

  # Page for all the payments of members/runners
  def view_children_payments
    authorize! :view_children_payments, Child
    @children = Child.all
  end

  # Page for all the requests to become a member/runner
  def approve_children
    authorize! :approve_children, Child
    @children = Db_queries.pending_children()
  end

  # Page for taking the attendance for a session
  def attendance
    authorize! :attendance, Child
    # Find all children with a group assigned
    @children = Child.where.not(:group_id => nil)
    # If the user is Head Admin
    if Db_queries.check_list_user_roles_smart(current_user.roles.pluck(:role_name), ['Head Admin'])
      # Show all schedules
      @schedules = Schedule.all
    else
      # Else display only the once available to the user
      @schedules = Schedule.accessible_by(current_ability, :helper)
    end
    # Active groups
    @group = Db_queries.active_groups()
  end

  # Events page
  def our_events
    authorize! :our_events, Event
    @title = params[:title]
    @date = params[:date]
    @details = params[:details]
    @series = params[:series]

    # Boolean for storing if an event is part of Series or not
    if @series == "True"
      @series_value = true
    elsif @series == "False"
      @series_value = false
    end

    # validation
    @validate = @title.nil? && @date.nil? && @details.nil?
    if !@validate
      # Create the event if the details pass the verifications
      event = Event.create!(date: @date, name: @title, series: @series_value, details: @details)
      redirect_to "/our_events"
    end
  end

  # Page for edit the details of children
  def edit_children
    authorize! :edit_children, Child
  end

  # Page for showing the details of children
  def my_children_details
    authorize! :my_children_details, Child
    @children = Child.where(:parent_id => Parent.where(user_id: current_user.id).first.id)
  end

  # Page for updating the groups for runners
  def move_members
    authorize! :move_members, Child
    # All active groups
    @groups = Db_queries.active_groups()
    # All children with a group assigned
    @children =  Child.where(:group_id => nil)
  end

  # Page for the medical details
  def med_details
    authorize! :med_details, Child
    # Children with a group assigned
    @children = Child.where.not(:group_id => nil)
    # Medical details with parameters
    @medical_d = params[:medical_details_field]
    # Child with the parameters
    @child = params[:child]
    # Update the medical details for a specific child
    Db_queries.set_child_medical_id(@child, @medical_d)
  end
  #end

  # Navifation bar page
  def _navbar
    # Roles
    @roles = Role.all
    # Users
    @users = User.all
  end

  # Page for a Parent, displaying the groups and their members if the parent's
  # child is assigned to that group
  def childrens_group
    authorize! :childrens_group, Child
    #@children = Child.where(:parent_id => current_user.parent.id)
    # Parent's children or child
    @children = Child.where(:parent_id => Parent.where(:user_id => current_user.id).first.id)
    # The group for the children, taking only the unique names
    @groups = @children.map{|e| e.group_id}.uniq.compact
  end

  # Assigning Coachs to schedules
  def assign_coaches
    authorize! :assign_coaches, Coach
  end

  # Add users page with more options dispalyed on that page
  def add_users
    authorize! :add_users, User
  end

  private
    def admin_signup
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_ids)
    end
end
