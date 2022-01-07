class FlashHashComponent < ViewComponent::Base
  attr_accessor :alerts

  def initialize(flash_hash:)
    super
    @alerts = flash_hash.map do |name, message|
      FlashAlert.new(name: name, message: message)
    end
  end

  class FlashAlert < ViewComponent::Base
    attr_accessor :message

    def initialize(name:, message:)
      super
      @name = name
      @message = message
    end

    def type
      case @name
      when 'alert'
        'error'
      when 'notice'
        'success'
      else
        'info'
      end
    end

    def call
      render(UswdsComponents::AlertComponent.new(status: type)) { message }
    end
  end
end
