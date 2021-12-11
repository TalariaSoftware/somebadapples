class OfficersController < ApplicationController
  def index
    @officers = Officer.all
  end

  def new
    @officer = Officer.new
  end

  def create
    officer = Officer.create! officer_params
    redirect_to officer
  end

  def show
    @officer = Officer.find params[:id]
  end

  def edit
    @officer = Officer.find params[:id]
  end

  def update
    officer = Officer.find params[:id]
    officer.update officer_params
    redirect_to officer
  end

  def destroy
    officer = Officer.find params[:id]
    officer.destroy!
    redirect_to officers_path
  end

  private

  def officer_params
    params.permit(:first_name, :last_name, :badge_number, :serial_number)
  end
end
