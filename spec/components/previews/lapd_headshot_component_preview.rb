class LapdHeadshotComponentPreview < ViewComponent::Preview
  # @param file_name select :file_names
  def default(file_name: 'MOORE MICHEL, R - # 23506.jpg')
    headshot = LapdHeadshot.new(file_name: file_name)
    render LapdHeadshotComponent.new(lapd_headshot: headshot)
  end

  private

  def file_names
    @file_names ||=
      ['Invalid filename', 'MOORE MICHEL, R - # 23506.jpg'] +
      LapdHeadshot.order(:file_name).limit(100).pluck(:file_name)
  end
end
