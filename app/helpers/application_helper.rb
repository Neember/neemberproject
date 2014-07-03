module ApplicationHelper
  def display_page_title(title)
    render partial: 'shared/breadcrumb', locals: { page_title: title }
  end
end
