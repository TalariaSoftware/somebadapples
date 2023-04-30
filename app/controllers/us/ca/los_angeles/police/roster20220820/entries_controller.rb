class Us::Ca::LosAngeles::Police::Roster20220820::EntriesController < ApplicationController # rubocop:disable Layout/LineLength
  include Pagy::Backend

  def index
    @pagy, @entries = pagy_arel(entries, items: 12)
  end

  def show
    @entry = Us::Ca::LosAngeles::Police::Roster20220820::Entry.find(params[:id])
    authorize @entry
  end

  private

  def entries
    policy_scope(
      Us::Ca::LosAngeles::Police::Roster20220820::Entry
      .all
      .order(:employee_name),
    )
  end
end
