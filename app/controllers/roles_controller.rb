class RolesController < ApplicationController
  expose :role, parent: :incident, decorate: ->(role) { authorize role }
  expose :incident

  def new
    @role = role
    @role.officer = Officer.new
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
    return existing_officer_role_params if existing_officer?

    new_officer_role_params
  end

  def existing_officer?
    params[:role][:officer_id].present?
    UUID.validate(params[:role][:officer_id])
  end

  def new_officer_role_params
    params
      .require(:role)
      .permit(
        :incident_id, :description,
        officer_attributes: officer_attribute_keys
      )
  end

  def existing_officer_role_params
    params
      .require(:role)
      .permit(:incident_id, :officer_id, :description)
  end

  def officer_attribute_keys
    %i[first_name middle_name last_name suffix]
  end
end
