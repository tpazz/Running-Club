# Email Controller class that coordinates the interaction between the user, email views and the email model

class EmailController < ApplicationController
  load_and_authorize_resource :email, :class => false
  # Helper methods accessible to views
  include MailerHelper

  # Contact us form-------------------------------------------------------------
  # Supplies the necessary parameters to the mailer for the Contact Us page
  # Retain user input on form if validation fails
  def contact_email
    @retain_name = $retain_n
    @retain_email = $retain_e
    @retain_message = $retain_m
  end

  def contact_email2
    $validation = true
    @contact = MailModel.new(contact_params)
    # Validation for presence, alphabetical name and valid email format
    if @contact.name.blank? || @contact.mail.blank? || @contact.message.blank?
      flash[:vblank] = "• Fields with an * cannot be left blank"
      $validation = false
    elsif !(Validation.alphabet(@contact.name)) && !(Validation.email_validation(@contact.mail))
      flash[:vblank] = "• Please enter a valid name and email"
      $validation = false
    elsif !Validation.alphabet(@contact.name)
      flash[:vblank] = "• Please enter a valid name"
      $validation = false
    elsif !Validation.email_validation(@contact.mail)
      flash[:vblank] = "• Please enter a valid email address"
      $validation = false
    else
      # Calls the mailer with supplied parameters and the associated view and sends email
      UserMailer.new_mail(@contact.name, @contact.mail, @contact.message).deliver
    end
    if !$validation
      $retain_n = @contact.name
      $retain_e = @contact.mail
      $retain_m = @contact.message
      redirect_back fallback_location: 'contact_us'
    else
      $retain_n = ""
      $retain_e = ""
      $retain_m = ""
    end
  end

  # Email user forms------------------------------------------------------------
  # Provides view with search parameter and list of users that match the search
  def email_user2
    @user = params[:search][:name]
    @users = User.all.where(first_name: params[:search][:name].capitalize)
  end

  # Provides the next view with the selected user
  def email_user3
    @user_id = (params[:recipent][:user_id])
    @user = User.find(@user_id)
  end

  # Supplies the necessary parameters to the mailer to email a user
  def email_user4
    @user_id = (params[:recipent][:user_id])
    @user = User.find(@user_id)
    @message = MailModel.new(individual_params)
    UserMailer.new_user_mail(@user.email, @user.first_name, @message.message).deliver
  end

  # Email coach forms-----------------------------------------------------------
  # Provides the view a list of all coaches
  def email_coach
    @r_id = Db_queries.role_id_by_role_name("Volunteer")
    @r_id2 = Db_queries.role_id_by_role_name("Run Leader")
    @user_ids = UserRole.where(role_id: @r_id) + UserRole.where(role_id: @r_id2)
    @all_coaches = User.where(id: @user_ids.pluck(:user_id))
  end

  # Provides the next view with the selected coach
  def email_coach2
    @user_id = (params[:recipent][:user_id])
    @user = User.find(@user_id)
  end

  # Supplies the necessary parameters to the mailer for sending email with an attachment
  def email_coach3
    @user_id = (params[:recipent][:user_id])
    @user = User.find(@user_id)
    @message = MailModel.new(coach_params)
    # If the user uploades an attachment
    if !params[:recipent][:attachment].nil? && !params[:recipent][:attachment].blank?
      file = params[:recipent][:attachment].tempfile.path
      file_name = params[:recipent][:attachment].original_filename
    # Otherwise variables left blank
    else
      file = ""
      file_name = ""
    end
    UserMailer.new_attachment_mail(@user.email, @user.first_name, @message.message, file_name, file).deliver
  end

  # Email group forms-----------------------------------------------------------
  # Provides view with list of active groups
  def email_group
    @all_groups = Db_queries.active_groups()
  end

  # Provides next view with selected group
  def email_group2
    @colour = params[:group_email][:group_name]
    @group_id = params[:group_email][:group_id]
  end

  # Supplies the necessary parameters to the mailer for emailing a group, or all groups
  def email_group3
    @colour = params[:group_email][:group_name]
    @message = MailModel.new(group_params)
    # Email all groups
    if @colour == "All"
      @all_group_id = Db_queries.active_groups().ids
      @all_group_email = []
      @all_group_id.each do |id|
        @all_group_email = @all_group_email + Db_queries.groups_parent_emails(id)
      end
      @all_group_email.each do |user|
        UserMailer.new_group_mail(user, @message.message, @colour).deliver
      end
    # Email selected group
    else
      @group_id = params[:group_email][:group_id]
      @group_email = Db_queries.groups_parent_emails(@group_id)
      @group_email.each do |user|
        UserMailer.new_group_mail(user, @message.message, @colour).deliver
      end
    end
  end

  # Email reminder (certificate expiration)-------------------------------------
  # Provides view with list of all coaches that have approved applications
  def email_expiration
    @timenow = Time.now
    @time = Time.now.strftime("%Y/%m/%d")
    @user_id = Coach.where(:appl_status => true).pluck(:user_id)
    @all_coaches = User.where(id: @user_id)
  end

  # Supplies the necessary parameters to the mailer for sending a reminder email
  def email_expiration2
    @user_id = params[:recipent][:user_id]
    @user = User.find(@user_id)
    @coach = params[:recipent][:coach]
    UserMailer.new_expiration_mail(@user.email, @user.first_name, @coach).deliver
  end

  # Email application status----------------------------------------------------
  # Provides view with list of pending coaches (non-approved coaches)
  def email_application_status
    @all_coaches = Db_queries.pending_coaches
  end

  # Approves the coach as Run Leader or Volunteer, or rejects their application
  # and supplies the necessary parameters to the mailer for sending application status
  def email_application_status2
    @user_id = params[:recipent][:user_id]
    @user = User.find(@user_id)
    if params[:volunteer]
      @status = "Volunteer"
      Db_queries.approve_coach_appl_vol(@user_id)
      UserMailer.new_status_mail(@user.email, @user.first_name, @status).deliver
    elsif params[:runl]
      @status = "Run Leader"
      Db_queries.approve_coach_appl_rl(@user_id)
      UserMailer.new_status_mail(@user.email, @user.first_name, @status).deliver
    elsif params[:reject]
      @status = "Rejected"
      @coach = Coach.where(user_id: @user_id).first
      Db_queries.delete_coach(@coach.id)
      UserMailer.new_status_mail(@user.email, @user.first_name, @status).deliver
    end
  end

  # Email params----------------------------------------------------------------
  # Params required for the mail model for sending emails
  def coach_params
    params.require(:recipent).except(:user_id, :attachment).permit(:message)
  end

  def contact_params
    params.require(:email).permit(:name, :mail, :message)
  end

  def group_params
    params.require(:group_email).except(:group_name, :group_id).permit(:message)
  end

  def individual_params
    params.require(:recipent).except(:user_id).permit(:message)
  end
end
