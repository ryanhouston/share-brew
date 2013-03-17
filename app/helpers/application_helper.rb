module ApplicationHelper
  def uses_javascript_application(js_id)
    @javascript_application = js_id
  end

  def javascript_application
    @javascript_application
  end
end
