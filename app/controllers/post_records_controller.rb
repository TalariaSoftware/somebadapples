class PostRecordsController < ApplicationController
  include Pagy::Backend

  expose :post_record, decorate: ->(post_record) { authorize post_record }

  before_action :ensure_uppercase_post_id, only: :index

  def index
    @pagy, @post_records = pagy_arel(post_records, items: 50)
  end

  private

  def post_records
    records = PostRecord.order(:officer_name)
    records = records.where(post_id: post_id) if post_id.present?
    policy_scope records
  end

  def ensure_uppercase_post_id
    return if post_id.blank?
    return if post_id == post_id.upcase

    redirect_to post_id_path(post_id: post_id.upcase)
  end

  def post_id
    params[:post_id]
  end
end
