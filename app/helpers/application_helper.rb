# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def if_admin?
    yield if current_user.admin?
  end

  def main_menu_item(name, url, logo = nil, with_logo = true)
    logo = logo && with_logo ? image_tag(logo) : ''

    link_to(
      logo + content_tag(:span, name),
      url,
      current_page?(url) ? {:class => 'current'} : {}
    )
  end

  def image_button_tag(image_path, label)
    %Q(<button class="save" type="submit">#{image_tag(image_path)} #{h(label)}</button>)
  end
  
  def image_link_to(image_path, label, url, options = {})
    content = image_tag(image_path) + h(" #{label}")
    link_to content, url, options
  end

  def add_button_tag(label = 'Create')
    image_button_tag 'add.png', label
  end
  
  def save_button_tag(label = 'Save')
    image_button_tag 'save.png', label
  end
  
  def cancel_button_tag(url, label = 'Cancel')
    image_link_to 'cancel.png', label, url, :class => 'button cancel'
  end
end
