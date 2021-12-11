class IncidentsController < ApplicationController
  expose :incident, build_params: -> { incident_params },
    decorate: ->(incident) { authorize incident }

  def new
    @incident = incident
  end

  def create
    incident.save!
    redirect_to incident.officer
  end

  def edit
    @incident = incident
  end

  def update
    incident.update incident_params
    redirect_to incident.officer
  end

  def destroy
    incident.destroy!
    redirect_to incident.officer
  end

  private

  def incident_params
    params
      .require(:incident)
      .permit(:officer_id, :description, :datetime)
  end
end
