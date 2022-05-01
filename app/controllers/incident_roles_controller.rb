class IncidentRolesController < ApplicationController
  expose :incident_role, parent: :incident,
    decorate: ->(role) { authorize role }
  expose :incident

  def new
    @incident_role = incident_role
  end

  def create
    incident_role.save!
    redirect_to incident
  end

  def edit
    @incident_role = incident_role
  end

  def update
    incident_role.update incident_role_params
    redirect_to incident_role.incident
  end

  def destroy
    incident_role.destroy!
    redirect_to incident
  end

  private

  def incident_role_params
    params
      .require(:incident_role)
      .permit(:incident_id, :officer_id, :description)
  end
end
