class AgenciesController < ApplicationController
  expose :agency, decorate: ->(agency) { authorize agency }
  expose :agencies, -> { policy_scope Agency.all }

  def index
    @agencies = agencies
  end

  def show
    @agency = agency
  end

  def new
    @agency = agency
  end

  def edit
    @agency = agency
  end

  def create
    agency.save!
    redirect_to agency
  end

  def update
    agency.update agency_params
    redirect_to agency
  end

  def destroy
    agency.destroy!
    redirect_to agencies_path
  end

  private

  def agency_params
    params
      .require(:agency)
      .permit(:name, :short_name)
  end
end
