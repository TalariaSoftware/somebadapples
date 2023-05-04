class Us::Ca::LosAngeles::Police::Headshots20230321::HeadshotsController < ApplicationController # rubocop:disable Layout/LineLength
  include Pagy::Backend

  def index
    @pagy, @headshots = pagy_arel(headshots, items: 12)
  end

  def show
    @headshot =
      Us::Ca::LosAngeles::Police::Headshots20230321::Headshot.find(params[:id])
    authorize @headshot
  end

  private

  def headshots
    policy_scope(
      Us::Ca::LosAngeles::Police::Headshots20230321::Headshot
      .all
      .order(:file_name),
    )
  end
end
