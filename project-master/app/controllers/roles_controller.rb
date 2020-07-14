class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /roles
  def index
    @roles = Role.all
  end

  # GET /roles/1
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to @role, notice: 'Role was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /roles/1
  def update
    if @role.update(role_params)
      redirect_to @role, notice: 'Role was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /roles/1
  def destroy
    @role.destroy
    redirect_to roles_url, notice: 'Role was successfully destroyed.'
  end

  def my_account_users
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @id = params[:id]
    Db_queries.set_user_first_name(@id, @first_name)
    Db_queries.set_user_last_name(@id, @last_name)
    Db_queries.set_user_email(@id, @email)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def role_params
      params.require(:role).permit(:role_name)
    end
end
