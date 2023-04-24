class LapdHeadshotComponent < ViewComponent::Base
  attr_accessor :lapd_headshot

  def initialize(lapd_headshot:)
    super
    @lapd_headshot = lapd_headshot
  end
end
