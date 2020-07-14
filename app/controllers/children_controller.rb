class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update, :destroy]
  authorize_resource


  # GET /children
  def index
    @children = Child.accessible_by(current_ability)
  end

  # GET /children/1
  def show
  end

  # GET /children/new
  def new
    @child = Child.new
  end

  # GET /children/1/edit
  def edit
  end

  # POST /children
  def create
    # Only parent can create parents
    begin
      @child = current_user.parent.child.new(create_child_params)

      if @child.save
        redirect_to @child, notice: 'Child was successfully created.'
      else
        render :new
      end
    rescue
      redirect_to '/'
    end
  end

  # PATCH/PUT /children/1
  def update
    # After updating the details, redirect to the show page
    # and diplay a message about the change
    if @child.update(child_params)
      redirect_to @child, notice: 'Child was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /children/1
  def destroy
    @child.destroy
     # If a parent is deleting a child, redirect to my_children page and display a message
     if Db_queries.check_list_user_roles_smart(current_user.roles.pluck(:role_name), ['Parent'])
       redirect_to my_children_url, notice: 'Child was successfully destroyed.'
    else
      # Else, any other use is deleting a child, redirect to the children page
      # with the notice specified below
      redirect_to children_url, notice: 'Child was successfully destroyed.'
    end
  end

  def mark_attendance
    # Using the schedule id and the child's id update in the database if
    # a child was present and left a session
    schedule_id = params[:schedule_id]
    child_id = params[:id]
    # Finding the session of the child based on the schedule
    attended = Attendance.where(schedule_id: schedule_id, child_id: child_id).first
    attended_number = attended.blank? ? 0 : attended.attended
    attendance = params[:attendance].blank? ? (attended_number == 2 ? 'out' : 'in') : params[:attendance]
    # In specifies that the child came to the session
    if attendance == 'in'
      if attended_number == 1
        attended.destroy
      else
        # By clicking on the thickbox 'in', update in the database that the child was present
        Db_queries.add_attendance_of_child_in(child_id, schedule_id, attended_number, attended)
      end
    else
      # By clicking on the 'out' thickbox update in the database that the child has left the
      # session
      if attended_number == 2
        Db_queries.add_attendance_of_child_in(child_id, schedule_id, attended_number, attended)
      else
        Db_queries.add_attendance_of_child_out(child_id, schedule_id, attended_number, attended)
      end
    end
  end

  def approve_children
    # Display all the children regstered for a membership
    @children = Db_queries.pending_children()
    # Option to dissaprove the child's request to join the club
    @disapprove = params[:disapprove]
    # Option to wait for a decision on child's request to join the club
    @waiting = params[:waiting]
    @child_id = params[:id]
    # Option to approve the child's request to join the club
    @group_name = params[:group]
    # An approved child will be immediately assigned to a group
    Db_queries.approve_child_appl(@child_id, Db_queries.group_name_to_id(@group_name))

    # Any other option than approved, will keep a record of  child
    # And a group will not be assigned
    if @group_name == "nil" or @waiting == 'in'
      Child.update(@child_id, group_id: nil)
    end

    # Delete the child if the request to join the club was rejected
    if @disapprove == 'in'
      Db_queries.delete_child(@child_id)
    end
  end

  def move_members
    # Taking the child id, an unique identifier
    @child_id = params[:id]
    # Update in the database a new group if changes were made by the user
    # The options are: any group other than the current one the child is in
    # Or to move the child to no group, because the child is inactive
    Db_queries.approve_child_appl(@child_id, Db_queries.group_name_to_id(params[:group]))
  end

  def view_children_payments
    # Update in the database in a child has paid or not
    @child_id = params[:id]
    if params[:payment] == 'in'
      Db_queries.set_child_paid(@child_id)
    else params[:payment] == 'out'
      Child.update(@child_id, paid: false)
    end
  end

  def med_details
    # A user can add medical details about a child
    # Taking the child's id and the parameters for medical details
    @child_id = params[:id]
    Db_queries.set_child_medical_id(@child_id, params[:medical_details_field])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def child_params
      params.require(:child).permit(:group_id, :parent_id, :first_name, :last_name, :gender, :date_of_birth, :photo, :inactive_days, :medical_issues, :collected, :paid, :doctor_name, :doctor_address, :doctor_postcode)
    end

    # Only allow a trusted parameter "white list" through.
    # Only parents can create, so restricted list
    def create_child_params
      params.require(:child).permit(:first_name, :last_name, :gender, :date_of_birth, :photo, :medical_issues, :collected, :doctor_name, :doctor_address, :doctor_postcode)
    end
end
