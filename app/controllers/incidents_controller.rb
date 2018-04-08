class IncidentsController < ApplicationController
  before_action :set_incident, only: [:update, :edit, :destroy, :show, :analyse, :capture]
  before_action :authenticate_user
  before_action :authenticate_analyst!, only: [:analyse, :solve_form, :capture]
  include UserHelper

  def show
  end

  def my_incidents
    if backofficer_signed_in?
      @my_incidents = Incident.where(backofficer_id: current_backofficer).paginate(page: params[:page], per_page: 10)
    else
      @my_incidents = Incident.where(analyst_id: current_analyst).paginate(page: params[:page], per_page: 10)
    end
  end

  def index
    @incidents = Incident.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.backofficer = current_backofficer

    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    #
  end

  def update
    respond_to do |format|
      if @incident.update(incident_params)
        if @incident.status == 'solved'
        format.html { redirect_to @incident, notice: 'Incident was successfully solved.' }
        elsif @incident.status == 'reopened'
          format.html { redirect_to @incident, notice: 'Incident was successfully reopened.' }
        else
          format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
        end
          format.json { render :show, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @incident.destroy
    format.html { redirect_to root, notice: 'Incident was successfully destroyed.' }
  end

  def analyse
    @incident.update(status: 4, analyst: current_analyst, analysis_started_at: DateTime.now)
    redirect_to @incident
  end

  def solve_form
    @incident = Incident.find(params[:id])
    redirect_to @incident unless check_to_solve
  end

  def pending_form
    @incident = Incident.find(params[:id])
    redirect_to @incident unless check_to_solve
  end

  def capture
    @incident.update(analyst_id: current_analyst.id, captured_by: current_analyst.name)
    redirect_to @incident
  end

  def search
    @incidents = Incident.search(params[:q]).paginate(page: params[:page], per_page: 10)
  end

  private

  def set_incident
    @incident = Incident.find(params[:incident_id]) unless @incident = Incident.find(params[:id])
  end

  def incident_params
    params.require(:incident).permit(:problem_kind, :priority_level, :analyst_id,
                                     :problem_description, :user_email, :title,
                                     :status, :solution_description,
                                     :analysis_time, :solution_time, :entity,
                                     :evidence_screen, :pending_description,
                                     :user_cpf, :contract_id, :plataform_kind)
  end

  def authenticate_user
    if check_user.class.name == "Backofficer"
      :authenticate_backofficer!
    elsif check_user.class.name == "Analyst"
      :authenticate_analyst!
    else
      redirect_to new_backofficer_session_path
    end
  end

  def check_to_solve
    @incident.status == 'analysing' && @incident.analyst_id == current_analyst.id
  end
end

