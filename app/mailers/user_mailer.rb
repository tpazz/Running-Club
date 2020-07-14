# User Mailer class that coordinates the interaction between the email controller
# and action mailer views for each email template

class UserMailer < ActionMailer::Base
  default from: 'Running Club <no-reply@sheffield.ac.uk>'
  # Helper method used in sending an expiration email
  helper MailerHelper

  # Provides associated view with what will be displayed in the email (Contact Us)
  def new_mail(name, mail, message)
    @name = name
    @mail = mail
    @message = message
    mail(:to => "r.horn@sheffield.ac.uk", :subject => "You have a message from #{@name}")
  end

  # Provides associated view with what will be displayed in the email (email a User)
  def new_user_mail(email, name, message)
    @email = email
    @name = name
    @message = message
    mail(:to => @email, :subject => "You have a message from HVH Running Club")
  end

  # Provides associated view with what will be displayed in the email (email a Group(s))
  def new_group_mail(email, message, colour)
    @email = email
    @message = message
    @colour = colour
    mail(:to => @email, :subject => "You have a message from HVH Running Club")
  end

  # Provides associated view with what will be displayed in the email (email a Coach w/wo attachment)
  def new_attachment_mail(email, name, message, file_name, file)
    @email = email
    @name = name
    @message = message
    if file != ""
      attachments[file_name] = File.read(file)
    end
    mail(:to => @email, :subject => "You have a message from HVH Running Club")
  end

  # Provides associated view with what will be displayed in the email (application status for Coaches)
  def new_status_mail(email, name, status)
    @email = email
    @name = name
    @status = status
    mail(:to => @email, :subject => "Your application from HVH has been processed")
  end

  # Provides associated view with what will be displayed in the email (certificate expiration for Coaches)
  def new_expiration_mail(email, name, coach)
    @email = email
    @name = name
    @coach = coach
    mail(:to => @email, :subject => "[REMINDER] You have a message from HVH Running Club")
  end
end
