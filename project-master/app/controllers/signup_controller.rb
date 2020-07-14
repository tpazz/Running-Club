# Controller used for the various signups
# Parent Signup (For any user)
# Coach Registration (for any user)
class SignupController < ApplicationController

  # GET /signup
  def new
    @user = User.new
    @user.parent = @user.build_parent
    @user.parent.phone_number << @user.parent.phone_number.new
    render 'devise/registrations/new'
  end

  # POST /signup
  def signup
    # Do I have to check if both User and Parent are valid? Or just user
    @user = User.new(signup_params)
    if @user.save
      parent_role = Role.where(:role_name => 'Parent').first
      @user.roles << parent_role
      redirect_to "/"
    else
      @user.parent = @user.build_parent
      @user.parent.phone_number << @user.parent.phone_number.new
      render 'devise/registrations/new'
    end
  end

  # GET /coach_registration
  def new_coach
    @user = User.new
    @user.coach = @user.build_coach
    @user.coach.document << @user.coach.document.new
    render 'signup/coach_registration'
  end

  # POST /coach_registration
  def coach_registration
    @user = User.new(coach_params)
    if @user.save
      redirect_to "/"
    else
      render 'signup/coach_registration'
    end
  end
  respond_to do |format|
    format.html
    format.js
  end

  private
  # Only allow a trusted parameter "white list" through.
    def signup_params
      params.require(:user).permit(:first_name, :last_name, :email, :s_email, :password, :password_confirmation, :parent_attributes => [:address, :postcode, :prime_mobile, :home_number, phone_number_attributes: [:phone_number, :_destroy]])
      #params.require(:parent).permit(:address, :postcode, :prime_mobile, :home_number)
    end

    def coach_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :coach_attributes => [:telephone, document_attributes: [:title, :description, :expiration, :_destroy]])
    end
end
