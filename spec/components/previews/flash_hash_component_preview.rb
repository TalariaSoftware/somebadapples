class FlashHashComponentPreview < ViewComponent::Preview
  def alert
    hash = ActionDispatch::Flash::FlashHash.new(alert: 'An alert message')

    render FlashHashComponent.new(flash_hash: hash)
  end

  def notice
    hash = ActionDispatch::Flash::FlashHash.new(notice: 'A notice message')

    render FlashHashComponent.new(flash_hash: hash)
  end

  def info
    hash = ActionDispatch::Flash::FlashHash.new(info: 'An info message')

    render FlashHashComponent.new(flash_hash: hash)
  end

  def multiple
    hash = ActionDispatch::Flash::FlashHash.new
    hash.alert = 'One alert message'
    hash.notice = 'One notice message'
    hash[:info] = 'One info message'

    render FlashHashComponent.new(flash_hash: hash)
  end
end
