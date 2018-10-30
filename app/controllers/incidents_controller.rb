class IncidentsController < ApplicationController
  before_action :set_incident, only: %i[update edit destroy show analyse
                                        capture reopen solve solution
                                        pending check_to_update]

  before_action :authenticate_user, only: %i[my_incidents search index]
  before_action :authenticate_backofficer!, only: [:create]
  before_action :authenticate_analyst!, only: %i[analyse solve capture solution]
  before_action :check_to_reopen, only: [:reopen]
  before_action :check_to_solve, only: [:solve]
  before_action :check_to_update, only: [:update]
  include UserHelper

  def show; end
  def edit; end
  def solve; end
  def pending; end
  def reopen; end

  def my_incidents
    if backofficer_signed_in?
      @my_incidents = Incident.where(backofficer_id: current_backofficer).paginate(page: params[:page], per_page: 10)
    else
      @my_incidents = Incident.where(analyst_id: current_analyst).paginate(page: params[:page], per_page: 10)
    end
  end

  def search
    @incidents = Incident.search(params[:q]).paginate(page: params[:page], per_page: 10)
  end

  def new
    @incident = Incident.new
  end

  def index
    @incidents = Incident.all.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  end

  def create
    @incident = current_backofficer.incidents.build(incident_params)
    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Requisição de urgência criada com sucesso.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @incident.update(incident_params)
        if incident_params[:status].nil? || incident_params[:status] == Enumerations::IncidentStatus::PENDING
          format.html { redirect_to @incident, notice: 'Requisição de urgência atualizada com sucesso.' }
        elsif incident_params[:status] == Enumerations::IncidentStatus::REOPENED
          format.html { redirect_to @incident, notice: 'Requisição de urgência reaberta.' }
        elsif incident_params[:status] == Enumerations::IncidentStatus::SOLVED
          format.html { redirect_to @incident, notice: 'Requisição de urgência resolvida.' }
        end
        format.json { render :show, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  def analyse
    @incident.update(status: Enumerations::IncidentStatus::ANALYSING, analyst: current_analyst, analysis_started_at: DateTime.now)
    flash[:notice] = 'Requisição em análise'
    redirect_to @incident
  end

  def capture
    @incident.update(analyst_id: current_analyst.id, captured_by: current_analyst.name)
    redirect_to @incident
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
    :problem_description, :user_email, :title, :status, :solution_description,
    :analysis_time, :solution_time, :entity, :evidence_screen, :pending_description,
    :user_cpf, :contract_id, :plataform_kind,:reopening_description, :reopened_by,
    :incident_reopened, :pending_reason)
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
      flash[:alert] = 'Você não tem permissão para resolver essa requisição.'
      redirect_to @incident
    end
  end

  def check_to_reopen
    redirect_to @incident unless
    (@incident.status == Enumerations::IncidentStatus::SOLVED ||
        @incident.status == Enumerations::IncidentStatus::REOPENED) &&
        authenticate_backofficer!
  end

  def check_to_update
    if incident_params[:status] == Enumerations::IncidentStatus::REOPENED && incident_params[:reopening_description].blank?
      flash[:alert] = 'Requisição não foi rebaberta. Motivo da reabertura deve ser preenchido.'
      redirect_to @incident
    elsif incident_params[:status] == Enumerations::IncidentStatus::SOLVED &&
        (incident_params[:solution_description].blank? || incident_params[:entity].blank?)
      flash[:alert] = 'Requisição não foi resolvida. Análise e contexto devem ser preenchidos.'
      redirect_to solve_path(id: @incident.id)
    elsif incident_params[:status] == Enumerations::IncidentStatus::PENDING &&
        (incident_params[:pending_reason].blank? || incident_params[:pending_description].blank?)
      flash[:alert] = 'Requisição não foi atualizada. Tipo e motivo do bloqueio devem ser preenchidos.'
      redirect_to pending_path(id: @incident.id)
    end
  end
end
