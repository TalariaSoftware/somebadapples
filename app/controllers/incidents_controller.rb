class IncidentsController < ApplicationController
  expose :incident, decorate: ->(incident) { authorize incident }
  expose :incidents, -> { policy_scope Incident.all }

  def index
    @incidents = incidents
  end

  def show
    @incident = incident
  end

  def new
    @incident = incident
  end

  def edit
    @incident = incident
  end

  def create
    incident.save!
    redirect_to incident
  end

  def update
    incident.update incident_params
    redirect_to incident
  end

  def destroy
    incident.destroy!
    redirect_to incident
  end

  private

  def incident_params
    params
      .require(:incident)
      .permit(:heading, :description, :datetime)
  end
end
