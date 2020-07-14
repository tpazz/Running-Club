# Helper Methods for mailing + other views that require certificate expiration
module MailerHelper
  # Creates a list of all coaches' qualifications
  def exp_list(coach)
    return Document.where(:coach_id => coach)
  end
  # Returns days until expiration
  def qualifications(exp)
    return (exp - Date.today).ceil
  end
end
