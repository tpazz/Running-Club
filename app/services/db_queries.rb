class Db_queries
  #Rules for this class:
  #1.Put any code you have that works(for pulling from db,in a suitable name)
  #2.Before adding a new one, check that it doesnt already exist
  #(another name, generic version with variable passing)
  #3.If you can make it work, write it here and use it from.
  #4.If not, just put a # ** and ask me or Sindre in the :role => "Coach")chat
  #5.Careful, dont change names
  # Exception Handling is functioning

  def self.pending_coaches()
    #Input: None (all info)
    #Output: List of all Coaches pending
    begin
      pend_coach = Coach.all.where(:appl_status => false).pluck(:user_id)
    rescue
      return false
    end
    return pend_coach
  end

  def self.coaches_all_users()
    #Input: None (all info)
    #Output: List of all coaches user_ids
    begin
      all_users = User.find(Coach.where.not(:appl_status => false ).pluck(:user_id))
    rescue
      return false
    end
    return all_users
  end

  def self.pending_children()
    #Input: None (all info)
    #Output: List of all children pending
    begin
      pending_childs = Child.all.where(:group => nil)
    rescue
      return false
    end
    return pending_childs
  end

  def self.active_groups()
    #Input: None (all info)
    #Output: List of all active groups
    begin
      active_groups = Group.all.where(:inactive => false)
    rescue
      return false
    end
    return active_groups
  end

  def self.inactive_groups()
    #Input: None (all info)
    #Output: List of all inactive groups
    begin
      inactive_groups = Group.all.where(:inactive => true)
    rescue
      return false
    end
    return inactive_groups
  end

  def self.children_paid_unpaid()
    #Input: None (all info)
    #Output: List all children, One paid, One unpaid
    begin
      paid =  Child.all.where(:paid => true)
      unpaid = Child.all.where(:paid => false)
    rescue
      return false
    end
    return paid , unpaid
  end

  def self.set_child_paid(child_id)
    #Input : ChildID
    #Output : Success of operation
    begin
      Child.update(child_id, paid: true)
    rescue
      return false
    end
    return true
  end

  def self.set_children_all_unpaid()
    #Input : None
    #Output: Failure or success of operation
    begin
      Child.all.ids.each do |child_id|
        Child.update(child_id, paid: false)
      end
    rescue
      return false
    end
    return true
  end

  def self.set_child_medical_id(childID, issue)
    #Input : ChildID , the issue
    #Output: Failure or success of operation
    begin
      child = Child.find_by_id(childID)
      child.update(medical_issues: issue)
    rescue
      return false
    end
    return true
  end

  def self.set_user_first_name(userID, firstName)
    #Input : userID , firstName
    #Output: Failure or success of operation
    begin
      user = User.find_by_id(userID)
      user.update(first_name: firstName)
    rescue
      return false
    end
    return true
  end

  def self.set_user_last_name(userID, lastName)
    #Input : userID , lastName
    #Output: Failure or success of operation
    begin
      user = User.find_by_id(userID)
      user.update(last_name: lastName)
    rescue
      return false
    end
    return true
  end

  def self.set_user_email(userID, email)
    #Input : userID , email
    #Output: Failure or success of operation
    begin
      user = User.find_by_id(userID)
      user.update(email: email)
    rescue
      return false
    end
    return true
  end

  def self.set_user_secondary_email(userID, secondary_email)
    #Input : userID , secondary_email
    #Output: Failure or success of operation
    begin
      user = User.find_by_id(userID)
      user.update(s_email: secondary_email)
    rescue
      return false
    end
    return true
  end

  def self.set_coach_phone(userID, phone)
    #Input : userID , phone
    #Output: Failure or success of operation
    begin
      coach = Coach.where(user_id: userID)
      coach.update(telephone: phone)
    rescue
      return false
    end
    return true
  end

  def self.set_parent_prime_mobile(userID, prime_mobile)
    #Input : userID , prime_mobile
    #Output: Failure or success of operation
    begin
      parent = Parent.where(id: userID)
      parent.update(prime_mobile: prime_mobile)
    rescue
      return false
    end
    return true
  end

  def self.set_parent_telephone(userID, telephone1)
    #Input : userID , telephone1
    #Output: Failure or success of operation
    begin
      phone = PhoneNumber.where(id: userID)
      phone.update(phone_number: telephone1)
    rescue
      return false
    end
    return true
  end

  def self.set_parent_home_number(userID, home_number)
    #Input : userID , home_number
    #Output: Failure or success of operation
    begin
      parent = Parent.where(id: userID)
      parent.update(home_number: home_number)
    rescue
      return false
    end
    return true
  end

  def self.set_parent_address(userID, address)
    #Input : userID , address
    #Output: Failure or success of operation
    begin
      parent = Parent.where(id: userID)
      parent.update(address: address)
    rescue
      return false
    end
    return true
  end

  def self.set_parent_postal_code(userID, postal_code)
    #Input : userID , postal_code
    #Output: Failure or success of operation
    begin
      parent = Parent.where(id: userID)
      parent.update(postcode: postal_code)
    rescue
      return false
    end
    return true
  end

  def self.add_attendance_of_child_in(child1_id , schedule1_id, attended_number, attended)
    #Input : None
    #Output : Failure or Success of operation
    begin
      if attended_number == 0
        Attendance.create!(child_id: child1_id, schedule_id: schedule1_id, attended: 1)
      else
        attended.update(attended: 1)
      end
      Child.update(child1_id , inactive_days: 0)
    rescue
      return false
    end
    return true
  end

  def self.add_attendance_of_child_out(child1_id , schedule1_id, attended_number, attended)
    #Input : None
    #Output : Failure or Success of operation
    begin
      if attended_number == 0
        Attendance.create!(child_id: child1_id, schedule_id: schedule1_id, attended: 2)
      else
        attended.update(attended: 2)
      end
      Child.update(child1_id , inactive_days: 0)
    rescue
      return false
    end
    return true
  end

  def self.add_inactive_day(childID)
    #Input: ChildID
    #Output: true for success, false for fail
    begin
      inactivity = Child.find(childID).inactive_days
      if not (inactivity < 6 )
        return true
      end
      inactivity = inactivity + 1
      Child.update(childID , inactive_days: inactivity)
    rescue
      return false
    end
    return true
  end

  def self.photo_permission(photo_int)
    #Input: ChildID
    #Output: Text for photo permission
    if (photo_int == 0)
      return 'No Photos Allowed'
    elsif (photo_int == 1)
      return 'Photos Allowed, without name'
    elsif (photo_int == 2)
      return 'Photos Allowed, with name'
    else
      return false
    end
  end

  def self.gender(gender_int)
    #Input: ChildID
    #Output: Text for photo permission
    if (gender_int == 1)
      return 'Male'
    elsif (gender_int == 2)
      return 'Female'
    elsif (gender_int == 0)
      return 'Other'
    else
      return false
    end
  end

  def self.approve_child_appl(childID, groupID)
    #Input: child_id and groupID
    #Output: True if succ, False if FAil
    begin
      Child.update(childID , group_id: groupID)
    rescue
      return false
    end
    return true
  end

  def self.approve_coach_appl_rl(coach_user_ID)
    #Input: A coach user ID
    #Output: True if succ, False if FAil
    begin
      coach_to_update = Coach.where(user_id: coach_user_ID).first
      if (coach_to_update.appl_status == true)
        return true
      end
      Coach.update(coach_to_update.id, appl_status: true)
      User.find(coach_user_ID).roles << Role.where(:role_name => "Run Leader").first
    rescue
      return false
    end
    return true
  end

  def self.approve_coach_appl_vol(coach_user_ID)
    #Input: A coach user ID
    #Output: True if succ, False if FAil
    begin
      coach_to_update = Coach.where(user_id: coach_user_ID).first
      if (coach_to_update.appl_status == true)
        return true
      end
      Coach.update(coach_to_update.id, appl_status: true)
      User.find(coach_user_ID).roles << Role.where(:role_name => "Volunteer").first
    rescue
      return false
    end
    return true
  end

  def self.set_coach_schedule_leader(coach_user_ID , schedule_ID) #also works for promotion
    #Input: Coach_user_ID , scheduleID
    #Output: If creating a session helper leader was successful or not
    begin
      leader_exists = (SessionHelper.where(:schedule_id => schedule_ID, :team_leader => true)) != []
      if(leader_exists) #if a leader already exists in this schedule
        return false #"Leader in that schedule already exists"
      end
      coach = Coach.where(:user_id => coach_user_ID).first.id
      coach_in_session = (SessionHelper.where(:coach_id => coach, :schedule_id => schedule_ID))
      if(coach_in_session != []) #if he is a helper, we now promote him to leader
        SessionHelper.find(coach_in_session.first.id).destroy
      end
      SessionHelper.create!(coach_id: coach, schedule_id: schedule_ID, team_leader: true)
    rescue
      return false
    end
    return true
  end

  def self.set_coach_schedule_helper(coach_user_ID , schedule_ID)
    #Input: Coach_user_ID , scheduleID
    #Output: If creating a session helper was successful
    begin
      coach = Coach.where(:user_id => coach_user_ID).first.id
      coach_in_session = (SessionHelper.where(:coach_id => coach, :schedule_id => schedule_ID)) != []
      if(coach_in_session)
        return  false #"Coach already in session"
      end
      SessionHelper.create!(coach_id: coach, schedule_id: schedule_ID, team_leader: false)
    rescue
      return false
    end
    return true
  end

  def self.children_only_emergency_phones(childID)
    #Input: ChildID
    #IN this function, we find all the possible phones and relationship
    #it returns, 1 list the phonelist, and 1 list the relationshiplist.
    #call by, phones,relationships = x.children...phones(childID)
    #returns 2 arrays, more convinient
    begin
      emerg = Child.find(childID).emergency_contact
      p_list = Struct.new(:phone , :relation)
      ph_rel_list = Array.new
      #initialisations to help for later
      emerg.each do |cur_emerg|
        temp = p_list.new cur_emerg.phone , cur_emerg.relationship
        ph_rel_list << temp
      end
    rescue
      return false
    end
    return ph_rel_list.compact()
    #Output: list of all emergency phones for the child
  end

  def self.children_all_emergency_phones(child)
    #Input: Child
    #Output: this function, we find all the possible phone and relationship
    #in a list
    begin
      emerg = child.emergency_contact
      parent = child.parent
      p_list = Struct.new(:phone , :relation)
      list = Array.new
      #initialisations to help for later
      found_phones = Hash.new(0) #this is to make sure we dont put diplicates
      emerg.each do |cur_emerg|
        current_phone = cur_emerg.phone
        current_rel = cur_emerg.relationship
        if found_phones[current_phone] == 0
          temp = p_list.new current_phone , current_rel
          list << temp
          found_phones[current_phone] = 1
        end
      end
      if found_phones[parent.prime_mobile] == 0
        temp = p_list.new parent.prime_mobile , "Parent Prime"
        list << temp
        found_phones[parent.prime_mobile] = 1
      end
      #up to here, we added all the phone numbers from the emerg list
      phone = PhoneNumber.where(:parent_id => parent.id)
      phone.each do |cur_phone|
        current_phone = cur_phone.phone_number
        if found_phones[current_phone] == 0
          temp = p_list.new current_phone , 'Parent'
          list << temp
          found_phones[current_phone] = 1
        end
      end
    rescue
      return false
    end
    return list.compact()
    #Output: list of all emergency phones for the child (inc parents)
  end

  def self.children_all_inactive()
    #Input: None
    #Output: list of all inactive children
    begin
      in_active_children = Child.where(inactive_days:6).uniq
    rescue
      return false
    end
    return in_active_children
  end

  def self.children_all_active()
    #Input: None
    begin
      active_children = Child.where("inactive_days < ?", 6)
    rescue
      return false
    end
    return active_children
    #Output: list of all active children
  end


  def self.coach_all_names_phones()
    #Input: None
    #Output: 2 lists, 1 for Volunteers , 1 for run leaders containing f, l name phone
    begin
      c_list = Struct.new(:f_name , :l_name , :phone)
      vol_list = Array.new
      rl_list = Array.new
      vol_id = role_id_by_role_name('Volunteer')
      rl_id = role_id_by_role_name('Run Leader')
      coach_list = Coach.where.not(:appl_status => false )
      coach_list.each do |cur_coach| #getting the detail for each coach 1 by 1
        cur_user = User.find(cur_coach.user_id)
        cur_user.user_roles.each do |cur_role| #checking each role of each coach
          if cur_role.role_id == vol_id #if he is a volunter
            temp = c_list.new cur_user.first_name , cur_user.last_name , cur_coach.telephone
            vol_list << temp
            break
          elsif cur_role.role_id == rl_id #if he is a coach
            temp = c_list.new cur_user.first_name , cur_user.last_name , cur_coach.telephone
            rl_list << temp
            break
          end
        end
      end
    rescue
      return false
    end
    return vol_list , rl_list
  end

  def self.user_all_emails()
    #Input:  None
    #Output: A list of all the emails of all users
    begin
      all_emails = User.all.pluck(:email, :s_email).flatten.compact().uniq
    rescue
      return false
    end
    return all_emails
  end

  def self.child_all_unpaid()
    #Input:  None
    #Output: list of all unpaid children
    begin
      unpaid_children = Child.where(paid:false)
    rescue
      return false
    end
    return unpaid_children
  end

  def self.role_id_by_role_name(role_name)
    #Input : the role name ( first Capital of each word, rest lowercase 'Parent')
    #Output: the correct role id
    begin
      role_id = Role.where(:role_name => role_name).first.id
    rescue
      return false
    end
    return role_id
  end

  def self.group_name_to_id(groupname)
    #Input : Group Name ( first Capital of each word, rest lowercase 'Blue Boys')
    #Output: Group id
    begin
      group_id = (Group.where(:group_name => groupname).ids)[0]
    rescue
      return false
    end
    return group_id
  end

  def self.groups_parent_emails(group_id) #**
    #Input: The id of a group
    #Output: A list of all the parents emails of that group?
    begin
      group = Group.find(group_id)
      child_ids = group.child.map {|child| child.parent}.pluck(:user_id)
      all_mails = child_ids.map{|id| User.find(id)}.pluck(:email, :s_email)
      all_mails = all_mails.flatten.compact().uniq
    rescue
      return false
    end
    return all_mails
  end

  def self.privilage_all_emails(privilage_name)
    #Input: the privilage group to select ('Parent' , 'Volunteer' , 'Run Leader')
    #Output: A list of all the emails for that privilage
    begin
      r_id = role_id_by_role_name(privilage_name)
      user_ids = UserRole.where(:role_id => r_id).pluck(:user_id)
      all_emails = User.where(:id => user_ids).pluck(:email,:s_email)
      all_emails = all_emails.flatten.compact().uniq
    rescue
      return false
    end
    return all_emails
  end

  def self.set_group_inactive(groupID)
    #Input:  groupID
    #Output: True if succ, False if FAil
    begin
      children = Group.find(groupID).child
      children.each do |child| #set every childs group to nil
        Child.update(child.id , group_id: nil)
      end
      Group.update(groupID ,  inactive: true )
    rescue
      return false
    end
    return true
  end

  def self.set_group_active(groupID)
    #Input: groupID
    #Output: True if succ, False if FAil
    begin
      Group.update(groupID ,  inactive: false )
    rescue
      return false
    end
    return true
  end

  def self.delete_group(groupID)
    #Input: groupID , doesnt destroy dependent
    #Output: True if succ, False if FAil
    begin
      group = Group.find(groupID)
      if not(group.inactive)
        return false
      end
      group.destroy
    rescue
      return false
    end
    return true
  end

  def self.set_child_inactive(childID)
    #Input: child_id and groupID
    #Output: True if succ, False if FAil
    begin
      Child.update(childID , group_id: nil)
    rescue
      return false
    end
    return true
  end

  def self.delete_child(childID)
    #Input: ChildID
    #Output: Sucess or failure of deleting the childID
    begin
      Child.find(childID).destroy
    rescue
      return false
    end
    return true
  end

  def self.delete_coach(coachID)
    #Input: CoachID
    #Output: Sucess or failure of deleting the CoachID
    begin
      coach = Coach.find(coachID)
      coach_user_id = coach.user_id
      coach.destroy
      if (UserRole.where(:user_id => coach_user_id).length <= 1)
        User.find(coach_user_id).destroy
      end
    rescue
      return false
    end
    return true
  end

  def self.display_combined_schedule()
    #Input: None
    #Output: The combined schedule
    begin
      s_list = Struct.new(:start_time ,:location , :group_name , :session , :group_colour)
      final_list = Array.new
      #initialisations to help for later
      all_times =((display_schedule()).pluck(:start_time ,:location)).uniq
      all_times.each do |time| #we generate each schedule for each unique start date and time here
        sessions = Schedule.where(:start_time => time[0]).pluck(:session_type)
        groups = Group.where(:id => (Schedule.where(:start_time => time[0]).pluck(:group_id))).pluck(:group_name)
        colours = Group.where(:id => (Schedule.where(:start_time => time[0]).pluck(:group_id))).pluck(:group_colour)
        temp = s_list.new time[0] , time[1] ,groups , sessions , colours
        final_list << temp
      end
    rescue
      return false
    end
    return final_list
  end


  def self.display_schedule()
    # Input: None
    # Output: Schedule sorted by date, and hide older than 7 days old
    # Remove older schedule than 7 days
    begin
      before_sorting = Schedule.all.select do |elem|
        elem[:start_time] > (Time.now - 7.day)
      end
      #Get remaining schedule, sort by date
      after_sorting = before_sorting.sort_by {|e| e.start_time}
    rescue
      return false
    end
    return after_sorting
  end

  def self.check_list_user_roles_smart(user_roles, list_roles)
    # Input: List of roles of user, list of roles to check for
    # Output: If the user has at least one of them
    if user_roles.blank?
      return false
    end
    intersection = user_roles & list_roles
    return intersection.length >= 1
  end

end
