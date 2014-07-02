module FeatureHelper
  def get_element(element)
    find("[data-test='#{element}']")
  end
end
