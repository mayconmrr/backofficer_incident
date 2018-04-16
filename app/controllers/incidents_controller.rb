class IncidentsController < ApplicationController
  before_action :set_incident,only: [:update, :edit, :destroy, :show, :analyse, :capture, :reopen, :solve, :pending]
  before_action :authenticate_user, only: [:my_incidents, :search]
  before_action :authenticate_backofficer!, only: [:create]
  before_action :authenticate_analyst!, only: [:analyse, :solve, :capture]

  before_action :check_to_reopen, only: [:reopen]
  before_action :check_to_solve, only: [:solve]
  include UserHelper

  def show; end

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

  def edit; end

  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
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
    @incident.update(status: Enumerations::IncidentStatus::ANALYSING, analyst: current_analyst, analysis_started_at: DateTime.now)
    flash[:notice] = 'Requisição em análise'
    redirect_to @incident
  end

  def solve
    binding.pry
    if @incident.update(incident_params)
      format.html { redirect_to @incident, notice: 'Requisição resolvida com sucesso!' }
      format.json { render :show, status: :ok }
    else
      format.html { render :new }
      format.json { render json: @incident.errors, status: :unprocessable_entity }
    end

    redirect_to @incident unless check_to_solve
  end

  def pending
    flash[:notice] = 'Requisição atualizada para pendente.'
  end

  def capture
    @incident.update(analyst_id: current_analyst.id, captured_by: current_analyst.name)
    redirect_to @incident
  end

  def reopen

    flash[:notice] = 'Requisição reaberta!'
  end

  def search
    @incidents = Incident.search(params[:q]).paginate(page: params[:page], per_page: 10)
  end

  private

  def set_incident
    if params[:id].present?
      @incident = Incident.find(params[:id])
    else
      @incident = Incident.find(params[:incident_id])
    end
  end

  def incident_params
    params.require(:incident).permit(:problem_kind, :priority_level, :analyst_id,
                                     :problem_description, :user_email, :title,
                                     :status, :solution_description,
                                     :analysis_time, :solution_time, :entity,
                                     :evidence_screen, :pending_description,
                                     :user_cpf, :contract_id, :plataform_kind,
                                     :reopening_description)
  end

  def authenticate_user
    if check_user.class.name == 'Backofficer'
      :authenticate_backofficer!
    elsif check_user.class.name == 'Analyst'
      :authenticate_analyst!
    else
      redirect_to new_backofficer_session_path
    end
  end

  def check_to_solve
    if @incident.status == Enumerations::IncidentStatus::ANALYSING && @incident.analyst == current_analyst
      true
    else
      flash[:danger] = 'Você não tem permissão para resolver essa requisição.'
      redirect_to @incident
    end
  end

  def check_to_reopen
    redirect_to @incident unless
    (@incident.status == Enumerations::IncidentStatus::SOLVED ||
        @incident.status == Enumerations::IncidentStatus::REOPENED) &&
        authenticate_backofficer!
  end
end

