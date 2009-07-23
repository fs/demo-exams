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
end
