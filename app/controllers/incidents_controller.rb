class IncidentsController < ApplicationController
  before_action :set_incident, only: [:update, :edit, :destroy, :show]
  before_action :authenticate_backofficer!
  include UserHelper

  def show
    @incident = Incident.find(params[:id])
  end

  def incident
    #binding.pry
    @incidents = check_user.incidents
  end

  def index
    @incidents = Incident.all
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
  end

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
    respond_to do |format|
      format.html { redirect_to root, notice: 'Incident was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private

  def set_incident
    @incident = Incident.find(params[:id])
  end

  def incident_params
    params.require(:incident).permit(:problem_kind, :priority_level,
                                     :description, :user_email, :title,
                                     :status, :solution_description,
                                     :analysis_time, :solution_time)
  end
end

