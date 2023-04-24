class LapdHeadshotsController < ApplicationController
  include Pagy::Backend

  expose :lapd_headshots, -> { policy_scope LapdHeadshot.all.order(:file_name) }

  def index
    @pagy, @lapd_headshots = pagy_arel(lapd_headshots, items: 10)
  end
end
