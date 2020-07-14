class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /parents
  def index
    @parents = Parent.all
  end

  # GET /parents/1
  def show
  end

  # GET /parents/new
  def new
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  def create
    @parent = Parent.new(parent_params)

    if @parent.save
      redirect_to @parent, notice: 'Parent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /parents/1
  def update
    if @parent.update(parent_params)
      redirect_to @parent, notice: 'Parent was successfully updated.'
    else
      render :edit
    end
  end

  #def delete_parent
  # @id = params[:id]
  #  Coach.where(user_id: @id).delete
  #end

  # DELETE /parents/1
  def destroy
    @parent.destroy
    redirect_to parents_url, notice: 'Parent was successfully destroyed.'
  end

  # My account functions to update parent's account
  def my_account_parent

    # Parameters selection
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @optional_email = params[:optional_email]
    @prime_mobile = params[:phone_number_1]
    @telephone1 = params[:phone_number_2]
    @home_number = params[:home_number]
    @address = params[:address]
    @post_code = params[:post_code]
    @id = params[:id]

    # Functions used for update
    Db_queries.set_user_first_name(@id, @first_name)
    Db_queries.set_user_last_name(@id, @last_name)
    Db_queries.set_user_email(@id, @email)
    Db_queries.set_user_secondary_email(@id, @optional_email)
    Db_queries.set_parent_prime_mobile(@id, @prime_mobile)
    Db_queries.set_parent_telephone(@id, @telephone1)
    Db_queries.set_parent_home_number(@id, @home_number)
    Db_queries.set_parent_address(@id, @address)
    Db_queries.set_parent_postal_code(@id, @post_code)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def parent_params
      params.require(:parent).permit(:address, :postcode, :home_number, :prime_mobile)
    end
end
