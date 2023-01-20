class SearchPaginationComponent < ViewComponent::Base
  attr_accessor :pagy, :query

  def initialize(pagy:, query:)
    super
    @pagy = pagy
    @query = query
  end

  def previous_page
    Previous.new(pagy: pagy, query: query)
  end

  def next_page
    Next.new(pagy: pagy, query: query)
  end

  class Previous < ViewComponent::Base
    attr_accessor :pagy, :query

    def initialize(pagy:, query:)
      super
      @pagy = pagy
      @query = query
    end

    def url
      search_path(q: query, page: pagy.prev)
    end

    def render?
      pagy.prev.present?
    end

    def call
      render UswdsComponents::PaginationComponent::Previous.new(url: url)
    end
  end

  class Next < ViewComponent::Base
    attr_accessor :pagy, :query

    def initialize(pagy:, query:)
      super
      @pagy = pagy
      @query = query
    end

    def url
      search_path(q: query, page: pagy.next)
    end

    def render?
      pagy.next.present?
    end

    def call
      render UswdsComponents::PaginationComponent::Next.new(url: url)
    end
  end

  class Item < ViewComponent::Base
    attr_accessor :item, :query

    def initialize(item:, query:)
      super
      @item = item
      @query = query
    end

    def url
      search_path(q: query, page: item)
    end

    def current?
      item.is_a? String
    end

    def gap?
      item == :gap
    end

    def call
      if gap?
        render UswdsComponents::PaginationComponent::Overflow.new
      else
        render UswdsComponents::PaginationComponent::Page.new(
          url: url, index: item, current: current?,
        )
      end
    end
  end
end
