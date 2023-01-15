class OfficersController < ApplicationController
  include Pagy::Backend

  expose :agency
  expose :officer, decorate: ->(officer) { authorize officer }
  expose :officers, -> { policy_scope agency.officers }

  def index
    @agency = agency
    @officers = officers.alphabetical

    respond_to do |format|
      format.html do
        @pagy, @officers = pagy_arel(@officers, items: 50)
      end

      format.csv
    end
  end

  def show
    @officer = officer
  end

  def new
    @officer = officer
  end

  def edit
    @officer = officer
  end

  def create
    officer.save!
    redirect_to officer
  end

  def update
    officer.update! officer_params
    redirect_to officer
  end

  def destroy
    officer.destroy!
    redirect_to officers_path
  end

  private

  def officer_params
    params
      .require(:officer)
      .permit(:first_name, :middle_name, :last_name, :suffix)
  end
end
