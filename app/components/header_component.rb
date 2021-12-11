class HeaderComponent < UswdsComponents::HeaderComponent
  def logo_title
    'Bad Apples'
  end

  def logo_href
    root_path
  end

  def menu_button_text
    'Menu'
  end

  def close_content
    image_tag(
      'https://cdn.jsdelivr.net/npm/uswds@2.10.3/dist/img/usa-icons/close.svg',
      role: :img,
      alt: :close,
    )
  end

  def primary_items
    [
      OfficerList.new,
    ]
  end

  class OfficerList < ViewComponent::Base
    def call
      link_to(officers_path, class: 'usa-nav__link') do
        'List'
      end
    end
  end
end
