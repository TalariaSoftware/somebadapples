class LapdHeadshotListComponent < ViewComponent::Base
  attr_accessor :lapd_headshots

  def initialize(lapd_headshots:)
    super
    @lapd_headshots = lapd_headshots
  end
end
