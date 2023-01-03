class PositionsController < ApplicationController
  expose :position, parent: :officer,
    decorate: ->(position) { authorize position }
  expose :officer

  def new
    @position = position
  end

  def edit
    @position = position
  end

  def create
    position.save!
    redirect_to officer
  end

  def update
    position.update position_params
    redirect_to position.officer
  end

  def destroy
    position.destroy!
    redirect_to position.officer
  end

  private

  def position_params
    params
      .require(:position)
      .permit(:agency_id, :badge_number, :serial_number)
  end
end
