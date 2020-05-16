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
    incidents = check_user.incidents
    incidents =
      if check_user.class.name == 'Backofficer'
        incidents.includes(:analyst)
      else
        incidents.includes(:backofficer)
      end

    @incidents = incidents.paginate(page: params[:page], per_page: 10)
    render 'index'
  end

  def search
    @incidents = Incident.search(params[:q])
                          .includes(:backofficer, :analyst)
                          .paginate(page: params[:page], per_page: 10)
    render 'index'
  end

  def index
    @incidents = Incident.includes(:backofficer, :analyst).all
                          .order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = current_backofficer.incidents.build(incident_params)
    if @incident.save
      redirect_to @incident, notice: 'Requisição de urgência criada com sucesso.'
    else
      render :new
    end
  end

  def update
    if @incident.update(incident_params)
      if incident_params[:status].nil? || incident_params[:status] == Status::PENDING
        redirect_to @incident, notice: 'Requisição de urgência atualizada com sucesso.'
      elsif incident_params[:status] == Status::REOPENED
        redirect_to @incident, notice: 'Requisição de urgência reaberta.'
      elsif incident_params[:status] == Status::SOLVED
        redirect_to @incident, notice: 'Requisição de urgência resolvida.'
      end
    else
      render :new
    end
  end

  def analyse
    @incident.update(status: Status::ANALYSING, analyst: current_analyst, analysis_started_at: DateTime.now)
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
    :contract_id, :plataform_kind,:reopening_description, :reopened_by,
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
    if @incident.status == Status::ANALYSING && @incident.analyst == current_analyst
      true
    else
      flash[:alert] = 'Você não tem permissão para resolver essa requisição.'
      redirect_to @incident
    end
  end

  def check_to_reopen
    redirect_to @incident unless
    (@incident.status == Status::SOLVED ||
        @incident.status == Status::REOPENED) &&
        authenticate_backofficer!
  end

  def check_to_update
    if incident_params[:status] == Status::REOPENED && incident_params[:reopening_description].blank?
      flash[:alert] = 'Requisição não foi rebaberta. Motivo da reabertura deve ser preenchido.'
      redirect_to @incident
    elsif incident_params[:status] == Status::SOLVED &&
        (incident_params[:solution_description].blank? || incident_params[:entity].blank?)
      flash[:alert] = 'Requisição não foi resolvida. Análise e contexto devem ser preenchidos.'
      redirect_to solve_path(id: @incident.id)
    elsif incident_params[:status] == Status::PENDING &&
        (incident_params[:pending_reason].blank? || incident_params[:pending_description].blank?)
      flash[:alert] = 'Requisição não foi atualizada. Tipo e motivo do bloqueio devem ser preenchidos.'
      redirect_to pending_path(id: @incident.id)
    end
  end
end
