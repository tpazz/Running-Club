class CoachesController < ApplicationController
  before_action :set_coach, only: [:show, :edit, :update, :destroy]
  authorize_resource
  include MailerHelper

  # GET /coaches
  def index
    @coaches = Coach.all.where(:appl_status => true)
  end

  # GET /coaches/1
  def show
  end

  # GET /coaches/new
  def new
    @coach = Coach.new
  end

  # GET /coaches/1/edit
  def edit
  end

  #def delete_coach
  #  @id = params[:id]
  #  Coach.where(user_id: @id).delete
  #end

  # POST /coaches
  def create
    @coach = Coach.new(coach_params)

    if @coach.save
      redirect_to @coach, notice: 'Coach was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /coaches/1
  def update
    if @coach.update(coach_params)
      redirect_to @coach, notice: 'Coach was successfully updated.'
    else
      render :edit
    end
  end

  # My account functions to update coach's account
  def my_account_coach

    # Parameters selection
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @optional_email = params[:optional_email]
    @phone_number = params[:phone_number_1]
    @id = params[:id]

    # Functions used for update
    Db_queries.set_user_first_name(@id, @first_name)
    Db_queries.set_user_last_name(@id, @last_name)
    Db_queries.set_user_email(@id, @email)
    Db_queries.set_user_secondary_email(@id, @optional_email)
    Db_queries.set_coach_phone(@id, @phone_number)
  end

  # DELETE /coaches/1
  def destroy
    @coach.destroy
    redirect_to coaches_url, notice: 'Coach was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach
      @coach = Coach.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coach_params
      params.require(:coach).permit(:user_id, :telephone, :DBS, :safe_qual, :first_aid, :coach_qual, :appl_status)
    end
end
