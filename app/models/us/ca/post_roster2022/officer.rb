class Us::Ca::PostRoster2022::Officer
  include ActiveModel::Model

  attr_accessor :post_id

  def entries
    Us::Ca::PostRoster2022::Entry.where(post_id: post_id)
  end
end
