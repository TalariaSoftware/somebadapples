class OfficersController < ApplicationController
  include Pagy::Backend

  expose :officer, decorate: ->(officer) { authorize officer }
  expose :officers, -> { policy_scope Officer.all }

  def index
    @pagy, @officers = pagy(officers.alphabetical)
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
