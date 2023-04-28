class LapdHeadshotListComponentPreview < ViewComponent::Preview
  # @param headshot_count Number of headshots in the list
  # @param file_name select :file_names
  def default(headshot_count: 3, file_name: 'MOORE MICHEL, R - # 23506.jpg')
    headshots = Array.new(headshot_count.to_i) do
      LapdHeadshot.new(file_name: file_name)
    end
    render LapdHeadshotListComponent.new(lapd_headshots: headshots)
  end

  private

  def file_names
    @file_names ||=
      ['Invalid filename', 'MOORE MICHEL, R - # 23506.jpg'] +
      LapdHeadshot.order(:file_name).limit(100).pluck(:file_name)
  end
end
