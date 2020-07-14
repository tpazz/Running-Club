class SessionHelpersController < ApplicationController
  before_action :set_session_helper, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :session_helper, :class => false

  # GET /session_helpers
  def index
    @session_helpers = SessionHelper.all
  end

  # GET /session_helpers/1
  def show
  end

  # GET /session_helpers/new
  def new
    @session_helper = SessionHelper.new
  end

  # GET /session_helpers/1/edit
  def edit
  end

  # POST /session_helpers
  def create
    @session_helper = SessionHelper.new(session_helper_params)

    if @session_helper.save
      redirect_to @session_helper, notice: 'Session helper was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /session_helpers/1
  def update
    if @session_helper.update(session_helper_params)
      redirect_to @session_helper, notice: 'Session helper was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /session_helpers/1
  def destroy
    @session_helper.destroy
    redirect_to session_helpers_url, notice: 'Session helper was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session_helper
      @session_helper = SessionHelper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def session_helper_params
      params.require(:session_helper).permit(:schedule_id, :coach_id)
    end
end
