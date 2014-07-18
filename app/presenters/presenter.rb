class Presenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  alias_method :model, :__getobj__
end
