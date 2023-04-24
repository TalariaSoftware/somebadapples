class PostRecordsController < ApplicationController
  include Pagy::Backend

  expose :post_record, decorate: ->(post_record) { authorize post_record }
  expose :post_records, -> { policy_scope PostRecord.all.order(:officer_name) }

  def index # rubocop:disable Metrics/AbcSize
    @post_records = post_records

    if params[:post_id].present?
      if params[:post_id] != params[:post_id].upcase
        redirect_to post_id_path(post_id: params[:post_id].upcase)
      end
      @post_records = @post_records.where(post_id: params[:post_id])
    end

    @pagy, @post_records = pagy_arel(@post_records, items: 50)
  end
end
