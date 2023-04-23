class PostRecordsController < ApplicationController
  include Pagy::Backend

  expose :post_record, decorate: ->(post_record) { authorize post_record }
  expose :post_records, -> { policy_scope PostRecord.all.order(:officer_name) }

  def index
    @pagy, @post_records = pagy_arel(post_records, items: 50)
  end
end
