class RolesController < ApplicationController
  expose :role, parent: :incident, decorate: ->(role) { authorize role }
  expose :incident

  def new
    @role = role
  end

  def create
    role.save!
    redirect_to incident
  end

  def edit
    @role = role
  end

  def update
    role.update role_params
    redirect_to role.incident
  end

  def destroy
    role.destroy!
    redirect_to incident
  end

  private

  def role_params
    params
      .require(:role)
      .permit(:incident_id, :officer_id, :description)
  end
end
