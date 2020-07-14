class InjuryRecordsController < ApplicationController
  before_action :set_injury_record, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /injury_records
  def index
    @injury_records = InjuryRecord.accessible_by(current_ability)

    #Get remaining schedule, sort by date
    @injury_records = @injury_records.sort_by {|e| e.schedule.start_time}.reverse

  end

  # GET /injury_records/1
  def show
  end

  # GET /injury_records/new
  def new
    @injury_record = InjuryRecord.new
  end

  # GET /injury_records/1/edit
  def edit
  end

  # POST /injury_records
  def create
    @injury_record = InjuryRecord.new(injury_record_params)

    if @injury_record.save
      redirect_to @injury_record, notice: 'Injury record was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /injury_records/1
  def update
    if @injury_record.update(injury_record_params)
      redirect_to @injury_record, notice: 'Injury record was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /injury_records/1
  def destroy
    @injury_record.destroy
    redirect_to injury_records_url, notice: 'Injury record was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_injury_record
      @injury_record = InjuryRecord.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def injury_record_params
      params.require(:injury_record).permit(:child_id, :injury, :schedule_id, :parent_notified)
    end
end
